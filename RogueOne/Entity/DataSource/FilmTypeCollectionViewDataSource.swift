//
//  FilmTypeCollectionViewDataSource.swift
//  RogueOne
//
//

import UIKit

class FilmTypeCollectionViewDataSource: SWEntitiesCollectionViewDataSource {
  var films: Films {
     guard let films = entities as? Films else {
       return []
     }
     return films
   }
   
   var filteredFilms: Films {
     guard let films = filtered as? Films else {
       return []
     }
     return films
   }

  init(worker: Fetchable,
       delegate: SWEntitiesCollectionViewDataSourceDelegate,
       cacheManager: CacheManager) {
    super.init(type: .films,
               worker: worker,
               delegate: delegate,
               cacheManager: cacheManager)
  }

  // Mark: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let swEntityCell = collectionView.dequeueReusableCell(withReuseIdentifier: SWEntityCollectionViewCell.reuseIdentifier,
                                                                for: indexPath) as? SWEntityCollectionViewCell else {
                                                                  return UICollectionViewCell()
    }
    let film = !searchActive ? films[indexPath.row] : filteredFilms[indexPath.row]
    var filmUrl = film.url
    if filmUrl.last == "/" {
      filmUrl.removeLast(1)
    }
    let lastComponent = filmUrl.components(separatedBy: "/").last ?? ""
    swEntityCell.configure(text: film.entityName,
                           imageName: "\(type.singularValue)-\(lastComponent)")
    return swEntityCell
  }
}
