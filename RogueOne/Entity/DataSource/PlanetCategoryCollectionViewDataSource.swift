//
//  PlanetCategoryCollectionViewDataSource.swift
//  RogueOne
//
//

import UIKit

class PlanetCategoryCollectionViewDataSource: SWEntitiesCollectionViewDataSource {
  private let type: SWEntityType = .planets
  private let worker: GetPlanetsWorker
  private(set) var planets: Planets = []

  init(worker: Fetchable,
       delegate: SWEntitiesCollectionViewDataSourceDelegate,
       cacheManager: CacheManager) {
    self.worker = worker as! GetPlanetsWorker
    super.init(type: type,
               delegate: delegate,
               cacheManager: cacheManager)
  }

  override func getEntities(_ completion: @escaping BoolClosure) {
    if let planetsMap = cacheManager.categoryMap[.planets], !planetsMap.isEmpty,
      let planets = Array(planetsMap.values) as? Planets {
      self.planets = planets
      completion(true)
      return
    }
    worker.getEntities(for: type,
                       success: { [weak self] (result) in
                        guard let strongSelf = self,
                          let planets = result as? Planets else {
                            completion(false)
                            return
                        }
                        strongSelf.planets = planets
                        completion(true)
      },
                       failure: { (error) in
                        print(error.localizedDescription)
                        completion(false)
    })
  }

  // Mark: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return planets.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let swEntityCell = collectionView.dequeueReusableCell(withReuseIdentifier: SWEntityCollectionViewCell.reuseIdentifier,
                                                                for: indexPath) as? SWEntityCollectionViewCell else {
                                                                  return UICollectionViewCell()
    }
    let planet = planets[indexPath.row]
    swEntityCell.configure(text: planet.entityName,
                           imageName: "\(type.singularValue)-\(indexPath.row+1)")
    return swEntityCell
  }
}
