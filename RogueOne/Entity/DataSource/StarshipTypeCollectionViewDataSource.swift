//
//  StarshipTypeCollectionViewDataSource.swift
//  RogueOne
//
//  Created by Dhaval on 5/15/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import UIKit

class StarshipTypeCollectionViewDataSource: SWEntitiesCollectionViewDataSource {
  var starships: Starships {
    guard let starships = entities as? Starships else {
      return []
    }
    return starships
  }

  var filteredStarships: Starships {
    guard let starships = filtered as? Starships else {
      return []
    }
    return starships
  }

  init(worker: Fetchable,
       delegate: SWEntitiesCollectionViewDataSourceDelegate,
       cacheManager: CacheManager) {
    super.init(type: .starships,
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
    let starship = !searchActive ? starships[indexPath.row] : filteredStarships[indexPath.row]
    var starshipUrl = starship.url
    if starshipUrl.last == "/" {
      starshipUrl.removeLast(1)
    }
    let lastComponent = starshipUrl.components(separatedBy: "/").last ?? ""
    swEntityCell.configure(text: starship.entityName,
                           imageName: "\(type.singularValue)-\(lastComponent)")
    return swEntityCell
  }

  override func updateSearchResults(for searchController: UISearchController) {
    let whitespaceCharacterSet = CharacterSet.whitespaces
    let searchString =
      searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)

    if !searchString.isEmpty {
      let filteredStarship = starships.filter {
        return $0.name.contains(searchString)
      }
      filtered = filteredStarship
    }
    delegate?.searchComplete()
  }

}
