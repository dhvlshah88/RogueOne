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
      return PeopleCategoryCollectionViewDataSource(worker: worker,
                                                    delegate: delegate,
                                                    cacheManager: cacheManager)
    case .films:
      return FilmCategoryCollectionViewDataSource(worker: worker,
                                                  delegate: delegate,
                                                  cacheManager: cacheManager)
    case .planets:
      return PlanetCategoryCollectionViewDataSource(worker: worker,
                                                    delegate: delegate,
                                                    cacheManager: cacheManager)
    default:
      return SWEntitiesCollectionViewDataSource(type: .films,
                                                delegate: delegate,
                                                cacheManager: cacheManager)
    }
  }
}
