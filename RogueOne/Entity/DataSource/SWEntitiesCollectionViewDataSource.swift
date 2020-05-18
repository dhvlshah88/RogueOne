//
//  SWEntitiesCollectionViewDataSource.swift
//  RogueOne
//
//

import UIKit

protocol SWEntitiesCollectionViewDataSourceDelegate: class {
  func presentSelectedEntityViewController(type: SWEntityType,
                                           entity: SWEntity,
                                           cacheManager: CacheManager)
  func searchComplete()
}

class SWEntitiesCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
  private let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  private let itemSpacing: CGFloat = 10.0

  var searchActive: Bool = false
  var type: SWEntityType
  var entities: Entities = [] {
    didSet {
      filtered = entities
    }
  }
  var filtered: Entities = []
  var totalEntitiesCount: Int = 0
  var nextPageUrl: String = ""
  var isGetInProgress: Bool = false
  var worker: Fetchable
  private(set) var cacheManager: CacheManager
  weak var delegate: SWEntitiesCollectionViewDataSourceDelegate?

  init(type: SWEntityType,
       worker: Fetchable,
       delegate: SWEntitiesCollectionViewDataSourceDelegate,
       cacheManager: CacheManager) {
    self.type = type
    self.worker = worker
    self.delegate = delegate
    self.cacheManager = cacheManager
  }

  func getEntities(_ completion: @escaping BoolClosure) {
    if let map = cacheManager.categoryMap[type], !map.isEmpty {
      let cachedEntities = Array(map.values)
      self.entities = cachedEntities
      completion(true)
      return
    }
    worker.getEntities(for: type,
                       success: { [weak self] response in
                        guard let strongSelf = self else {
                            completion(false)
                            return
                        }

                        strongSelf.entities = response.result
                        strongSelf.totalEntitiesCount = response.count
                        strongSelf.nextPageUrl = response.next
                        //TO-DO - Add to entities to cache for reduce api traffic.
                        completion(true)
      },
                       failure: { (error) in
                        print(error.localizedDescription)
                        completion(false)
    })
  }

  // MARK: UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if searchActive {
      return filtered.count
    }
    return totalEntitiesCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }

  // MARK: UICollectionViewDelegate
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.presentSelectedEntityViewController(type: type,
                                                  entity: entities[indexPath.row],
                                                  cacheManager: cacheManager)
  }
}

extension SWEntitiesCollectionViewDataSource: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      getNextEntities { [weak self] nextEntities in
        guard let strongSelf = self, let nextEntities = nextEntities, !nextEntities.isEmpty else {
          return
        }
        let nextIndexPathsToBeReload = strongSelf.calculateIndexPathsToReload(from: nextEntities)
        let visibleIndexPaths = strongSelf.indexPathsToReload(visibleIndexPaths: collectionView.indexPathsForVisibleItems, intersecting: nextIndexPathsToBeReload)
        collectionView.reloadItems(at: visibleIndexPaths)
      }
    }
  }

  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= entities.count
  }

  private func getNextEntities(_ completion: @escaping EntitiesClosure) {
    if let map = cacheManager.categoryMap[type], !map.isEmpty {
      let cachedEntities = Array(map.values)
      self.entities = cachedEntities
      completion(cachedEntities)
      return
    }
    guard !isGetInProgress else {
      return
    }
    isGetInProgress = true
    worker.getNextEntities(for: nextPageUrl,
                       success: { [weak self] response in
                        guard let strongSelf = self else {
                          completion([])
                          return
                        }
                        strongSelf.isGetInProgress = false
                        strongSelf.entities.append(contentsOf: response.result)
                        strongSelf.nextPageUrl = response.next
                        //TO-DO - Add to entities to cache for reduce api traffic.
                        completion(response.result)
      },
                       failure: { [weak self] error in
                        guard let strongSelf = self else {
                          completion(nil)
                          return
                        }
                        strongSelf.isGetInProgress = false
                        completion(nil)
    })
  }

  private func calculateIndexPathsToReload(from newEntities: Entities) -> [IndexPath] {
    let startIndex = entities.count - newEntities.count
    let endIndex = startIndex + newEntities.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
  }

  private func indexPathsToReload(visibleIndexPaths: [IndexPath], intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsIntersection = Set(visibleIndexPaths).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }

}

extension SWEntitiesCollectionViewDataSource: UICollectionViewDelegateFlowLayout {

  // MARK: UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfItems = 2
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

    let totalWidthForCells = collectionView.bounds.width
      - (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItems - 1))
      - (sectionInsets.left + sectionInsets.right)

    let widthPerCell = totalWidthForCells / CGFloat(numberOfItems)
    return CGSize(width: widthPerCell, height: widthPerCell)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return itemSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return itemSpacing
  }
}

extension SWEntitiesCollectionViewDataSource: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) { }

}
