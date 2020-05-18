//
//  GetPeopleEntitiesWebService.swift
//  RogueOne
//
//

import Foundation

class GetPeopleEntitiesWebService: SWCategoriesWebService<SWEntitiesRequest, PeopleEntitiesResponse> {
  override func responseFromData(_ data: Data) throws -> PeopleEntitiesResponse {
    return try newJSONDecoder().decode(PeopleEntitiesResponse.self,
                                       from: data)
  }
}
