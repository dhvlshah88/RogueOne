//
//  GetStarshipsWorker.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/15/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

class GetStarshipsWorker: Fetchable {
  lazy var starshipsWebservice = GetStarshipEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWEntitiesResponseClosure,
                   failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(type: type)
    starshipsWebservice.call(request: request,
                             success: { (response) in
                              success(response)
    },
                             failure: failure)
  }

  func getNextEntities(for urlString: String, success: @escaping SWEntitiesResponseClosure, failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(urlString)
    starshipsWebservice.call(request: request,
                           success: { response in
                            success(response)
    },
                           failure: failure)
  }
}
