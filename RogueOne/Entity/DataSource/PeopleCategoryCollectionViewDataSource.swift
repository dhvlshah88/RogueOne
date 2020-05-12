//
//  PeopleCategoryCollectionViewDataSource.swift
//  RogueOne
//
//

import UIKit

class PeopleCategoryCollectionViewDataSource: SWEntitiesCollectionViewDataSource {
  private let type: SWEntityType = .people
  private let worker: GetPeoplesWorker
  private(set) var peoples: Peoples = []
  private(set) var filteredPeoples: Peoples = []

  init(worker: Fetchable,
       delegate: SWEntitiesCollectionViewDataSourceDelegate,
       cacheManager: CacheManager) {
    self.worker = worker as! GetPeoplesWorker
    super.init(type: type,
               delegate: delegate,
               cacheManager: cacheManager)
  }

  override func getEntities(_ completion: @escaping BoolClosure) {
    if let peoplesMap = cacheManager.categoryMap[.people], !peoplesMap.isEmpty,
      let peoples = Array(peoplesMap.values) as? Peoples {
      self.peoples = peoples
      completion(true)
      return
    }
    worker.getEntities(for: type,
                       success: { [weak self] (result) in
                        guard let strongSelf = self,
                          let peoples = result as? Peoples else {
                            completion(false)
                            return
                        }
                        strongSelf.peoples = peoples
                        strongSelf.cacheManager.addPeoples(peoples)
                        completion(true)
      },
                       failure: { (error) in
                        print(error.localizedDescription)
                        completion(false)
    })
  }

  // Mark: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if searchActive {
      return filteredPeoples.count
    }
    return peoples.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let swEntityCell = collectionView.dequeueReusableCell(withReuseIdentifier: SWEntityCollectionViewCell.reuseIdentifier,
                                                                for: indexPath) as? SWEntityCollectionViewCell else {
                                                                  return UICollectionViewCell()
    }
    let people = !searchActive ? peoples[indexPath.row] : filteredPeoples[indexPath.row]
    var peopleUrl = people.url
    if peopleUrl.last == "/" {
      peopleUrl.removeLast(1)
    }
    let lastComponent = peopleUrl.components(separatedBy: "/").last ?? ""
    swEntityCell.configure(text: people.entityName,
                           imageName: "\(type.singularValue)-\(lastComponent)")
    return swEntityCell
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let people = peoples[indexPath.row]
    delegate?.presentSelectedEntityViewController(type: type,
                                                  entity: people,
                                                  cacheManager: cacheManager)
  }

  override func updateSearchResults(for searchController: UISearchController)
  {
    filteredPeoples = peoples
    let whitespaceCharacterSet = CharacterSet.whitespaces
    let searchString =
      searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)

    if !searchString.isEmpty {
      let filtered = peoples.filter {
        return $0.name.contains(searchString)
      }
      filteredPeoples = filtered
    }
    delegate?.searchComplete()
  }

}
