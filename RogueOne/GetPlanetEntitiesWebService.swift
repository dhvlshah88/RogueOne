//
//  GetPlanetEntitiesWebService.swift
//  RogueOne
//
//

import Foundation

class GetPlanetEntitiesWebService: SWCategoriesWebService<SWCategoryRequest, PlanetEntitiesResponse> {
  override func responseFromData(_ data: Data) throws -> PlanetEntitiesResponse {
    return try newJSONDecoder().decode(PlanetEntitiesResponse.self,
                                       from: data)
  }
}

