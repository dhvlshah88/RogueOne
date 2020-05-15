//
//  GelFilmsWorker.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/15/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

class GetFilmsWorker: Fetchable {
  lazy var filmsWebservice = GetFilmEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure) {
    let request = SWCategoryRequest(type: type)
    filmsWebservice.call(request: request,
                         success: { (response) in
                          success(response.results)
    },
                         failure: failure)
  }
}
