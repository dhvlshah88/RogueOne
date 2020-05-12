//
//  GetStarshipEntitiesWebService.swift
//  RogueOne
//
//

import Foundation

class GetStarshipEntitiesWebService: SWCategoriesWebService<SWCategoryRequest, StarshipEntitiesResponse> {
  override func responseFromData(_ data: Data) throws -> StarshipEntitiesResponse {
    return try newJSONDecoder().decode(StarshipEntitiesResponse.self,
                                       from: data)
  }
}
