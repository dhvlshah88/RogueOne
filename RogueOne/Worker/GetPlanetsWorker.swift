//
//  GetPlanetsWorker.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/15/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

class GetPlanetsWorker: Fetchable {
  lazy var planetsWebservice = GetPlanetEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWEntitiesResponseClosure,
                   failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(type: type)
    planetsWebservice.call(request: request,
                           success: success,
                           failure: failure)
  }

  func getNextEntities(for urlString: String,
                       success: @escaping SWEntitiesResponseClosure,
                       failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(urlString)
    planetsWebservice.call(request: request,
                           success: success,
                           failure: failure)

  }
}
