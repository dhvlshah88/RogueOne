//
//  GelFilmsWorker.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/15/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

class GetFilmsWorker: Fetchable {
  lazy var speciesWebService = GetSpeciesEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWEntitiesResponseClosure,
                   failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(type: type)
    speciesWebService.call(request: request,
                         success: { (response) in
                          success(response)
    },
                         failure: failure)
  }

  func getNextEntities(for urlString: String, success: @escaping SWEntitiesResponseClosure, failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(urlString)
    speciesWebService.call(request: request,
                             success: { response in
                              success(response)
    },
                             failure: failure)
  }
}
