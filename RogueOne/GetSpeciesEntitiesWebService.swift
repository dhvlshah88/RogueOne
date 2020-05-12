//
//  GetSpeciesEntitiesWebService.swift
//  RogueOne
//
//

import Foundation

class GetSpeciesEntitiesWebService: SWCategoriesWebService<SWCategoryRequest, SpeciesEntitiesResponse> {
  override func responseFromData(_ data: Data) throws -> SpeciesEntitiesResponse {
    return try newJSONDecoder().decode(SpeciesEntitiesResponse.self,
                                       from: data)
  }
}
