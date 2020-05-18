//
//  GetPeoplesWorker.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/15/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

protocol Fetchable {
  func getEntities(for type: SWEntityType,
                   success: @escaping SWEntitiesResponseClosure,
                   failure: @escaping FailureClosure)

  func getNextEntities(for urlString: String,
                       success: @escaping SWEntitiesResponseClosure,
                       failure: @escaping FailureClosure)
}

class GetPeoplesWorker: Fetchable {
  lazy var peoplesWebservice = GetPeopleEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWEntitiesResponseClosure,
                   failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(type: type)
    peoplesWebservice.call(request: request,
                           success: { response in
                            success(response)
    },
                           failure: failure)
  }

  func getNextEntities(for urlString: String,
                       success: @escaping SWEntitiesResponseClosure,
                       failure: @escaping FailureClosure) {
    let request = SWEntitiesRequest(urlString)
    peoplesWebservice.call(request: request,
                           success: { response in
                            success(response)
    },
                           failure: failure)
  }
}
