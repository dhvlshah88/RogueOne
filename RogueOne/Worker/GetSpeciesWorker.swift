//
//  GetSpeciesWorker.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/15/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

class GetSpeciesWorker: Fetchable {
  lazy var speciesWebservice = GetSpeciesEntitiesWebService.default()
  
  func getEntities(for type: SWEntityType,
                   success: @escaping SWEntitiesResponseClosure,
                   failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(type: type)
    speciesWebservice.call(request: request,
                           success: success,
                           failure: failure)
  }
  
  func getNextEntities(for urlString: String,
                       success: @escaping SWEntitiesResponseClosure,
                       failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(urlString)
    speciesWebservice.call(request: request,
                           success: success,
                           failure: failure)
  }
}
