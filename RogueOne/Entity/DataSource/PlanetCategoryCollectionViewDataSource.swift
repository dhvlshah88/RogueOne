//
//  PlanetCategoryCollectionViewDataSource.swift
//  RogueOne
//
//

import UIKit

class PlanetCategoryCollectionViewDataSource: SWEntitiesCollectionViewDataSource {
  var planets: Planets {
    guard let planets = entities as? Planets else {
      return []
    }
    return planets
  }

  var filteredPlanets: Planets {
    guard let planets = filtered as? Planets else {
      return []
    }
    return planets
  }

  init(worker: Fetchable,
       delegate: SWEntitiesCollectionViewDataSourceDelegate,
       cacheManager: CacheManager) {
    super.init(type: .planets,
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
    let planet = !searchActive ? planets[indexPath.row] : filteredPlanets[indexPath.row]
    var planetUrl = planet.url
    if planetUrl.last == "/" {
      planetUrl.removeLast(1)
    }
    let lastComponent = planetUrl.components(separatedBy: "/").last ?? ""
    swEntityCell.configure(text: planet.entityName,
                           imageName: "\(type.singularValue)-\(lastComponent)")
    return swEntityCell
  }

  override func updateSearchResults(for searchController: UISearchController) {
    let whitespaceCharacterSet = CharacterSet.whitespaces
    let searchString =
      searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)

    if !searchString.isEmpty {
      let filteredPlanets = planets.filter {
        return $0.name.contains(searchString)
      }
      filtered = filteredPlanets
    }
    delegate?.searchComplete()
  }
}
