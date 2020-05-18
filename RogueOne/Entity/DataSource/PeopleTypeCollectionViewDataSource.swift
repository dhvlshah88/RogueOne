//
//  PeopleTypeCollectionViewDataSource.swift
//  RogueOne
//
//

import UIKit

class PeopleTypeCollectionViewDataSource: SWEntitiesCollectionViewDataSource {
  var peoples: Peoples {
     guard let peoples = entities as? Peoples else {
       return []
     }
     return peoples
   }

   var filteredPeoples: Peoples {
     guard let peoples = filtered as? Peoples else {
       return []
     }
     return peoples
   }

  init(worker: Fetchable,
       delegate: SWEntitiesCollectionViewDataSourceDelegate,
       cacheManager: CacheManager) {
    super.init(type: .people,
               worker: worker,
               delegate: delegate,
               cacheManager: cacheManager)
  }

  // MARK: UICollectionViewDataSource
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

  override func updateSearchResults(for searchController: UISearchController) {
    let whitespaceCharacterSet = CharacterSet.whitespaces
    let searchString =
      searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)

    if !searchString.isEmpty {
      let filteredPeoples = peoples.filter {
        return $0.name.contains(searchString)
      }
      filtered = filteredPeoples
    }
    delegate?.searchComplete()
  }

}
