//
//  GetPeoplesWorker.swift
//  RogueOne
//
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
