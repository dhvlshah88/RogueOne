//
//  EntitiesDataSourceFactory.swift
//  RogueOne
//
//

import Foundation

struct EntitiesDataSourceFactory {
  static func getEntitiesDataSource(for type: SWEntityType,
                                    delegate: SWEntitiesCollectionViewDataSourceDelegate,
                                    cacheManager: CacheManager) -> SWEntitiesCollectionViewDataSource {
    let worker = WorkerFactory.getCategoryWorker(for: type)
    switch type {
    case .people:
      return PeopleTypeCollectionViewDataSource(worker: worker,
                                                delegate: delegate,
                                                cacheManager: cacheManager)
    case .films:
      return FilmTypeCollectionViewDataSource(worker: worker,
                                              delegate: delegate,
                                              cacheManager: cacheManager)
    case .planets:
      return PlanetCategoryCollectionViewDataSource(worker: worker,
                                                    delegate: delegate,
                                                    cacheManager: cacheManager)
      
    case .starships:
      return StarshipTypeCollectionViewDataSource(worker: worker,
                                                  delegate: delegate,
                                                  cacheManager: cacheManager)
    case .vehicles:
      return SWEntitiesCollectionViewDataSource(type: .vehicles,
                                                worker: worker,
                                                delegate: delegate,
                                                cacheManager: cacheManager)
    case.species:
      return SWEntitiesCollectionViewDataSource(type: .species,
                                                worker: worker,
                                                delegate: delegate,
                                                cacheManager: cacheManager)
    }
  }
}
