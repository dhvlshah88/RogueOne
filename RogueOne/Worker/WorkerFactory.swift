//
//  WorkerFactory.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/15/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

struct WorkerFactory {
  static func getCategoryWorker(for type: SWEntityType) -> Fetchable {
    switch type {
    case .people:
      return GetPeoplesWorker()
    case .films:
      return GetFilmsWorker()
    case .planets:
      return GetPlanetsWorker()
    case .species:
      return GetSpeciesWorker()
    case .starships:
      return GetStarshipsWorker()
    case .vehicles:
      return GetVehiclesWorker()
    }
  }
}
