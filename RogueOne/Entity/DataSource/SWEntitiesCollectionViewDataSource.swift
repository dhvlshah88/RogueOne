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

class SWEntitiesCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
                       success: { [weak self] (result) in
                        guard let strongSelf = self else {
                            completion(false)
                            return
                        }
                        strongSelf.entities = result
                        completion(true)
      },
                       failure: { (error) in
                        print(error.localizedDescription)
                        completion(false)
    })
  }
  
  // Mark: UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if searchActive {
      return filtered.count
    }
    return entities.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
  
  // Mark: UICollectionViewDelegate
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.presentSelectedEntityViewController(type: type,
                                                  entity: entities[indexPath.row],
                                                  cacheManager: cacheManager)
  }
  
  // Mark: UICollectionViewDelegateFlowLayout
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
