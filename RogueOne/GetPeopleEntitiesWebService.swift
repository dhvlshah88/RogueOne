//
//  GetPeopleEntitiesWebService.swift
//  RogueOne
//
//

import Foundation

class GetPeopleEntitiesWebService: SWCategoriesWebService<SWCategoryRequest, PeopleEntitiesResponse> {
  override func responseFromData(_ data: Data) throws -> PeopleEntitiesResponse {
    return try newJSONDecoder().decode(PeopleEntitiesResponse.self,
                                       from: data)
  }
}
