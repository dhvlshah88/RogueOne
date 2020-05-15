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
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure)
}

class GetPeoplesWorker: Fetchable {
  lazy var peoplesWebservice = GetPeopleEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure) {
    let request = SWCategoryRequest(type: type)
    peoplesWebservice.call(request: request,
                           success: { (response) in
                            success(response.results)
    },
                           failure: failure)
  }
}
