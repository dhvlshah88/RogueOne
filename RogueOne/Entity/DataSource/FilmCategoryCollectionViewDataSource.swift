//
//  FilmCategoryCollectionViewDataSource.swift
//  RogueOne
//
//

import UIKit

class FilmCategoryCollectionViewDataSource: SWEntitiesCollectionViewDataSource {
  private let type: SWEntityType = .films
  private let worker: GetFilmsWorker
  private(set) var films: Films = []

  init(worker: Fetchable,
       delegate: SWEntitiesCollectionViewDataSourceDelegate,
       cacheManager: CacheManager) {
    self.worker = worker as! GetFilmsWorker
    super.init(type: type,
               delegate: delegate,
               cacheManager: cacheManager)
  }

  override func getEntities(_ completion: @escaping BoolClosure) {
    if let filmsMap = cacheManager.categoryMap[.films], !filmsMap.isEmpty,
      let films = Array(filmsMap.values) as? Films {
      self.films = films
      completion(true)
      return
    }
    worker.getEntities(for: type,
                       success: { [weak self] (result) in
                        guard let strongSelf = self,
                          let films = result as? Films else {
                            completion(false)
                            return
                        }
                        strongSelf.films = films
                        strongSelf.cacheManager.addFilms(films)
                        completion(true)
      },
                       failure: { (error) in
                        print(error.localizedDescription)
                        completion(false)
    })
  }

  // Mark: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return films.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let swEntityCell = collectionView.dequeueReusableCell(withReuseIdentifier: SWEntityCollectionViewCell.reuseIdentifier,
                                                                for: indexPath) as? SWEntityCollectionViewCell else {
                                                                  return UICollectionViewCell()
    }
    let film = films[indexPath.row]
    swEntityCell.configure(text: film.entityName,
                           imageName: "\(type.singularValue)-\(indexPath.row+1)")
    return swEntityCell
  }
}