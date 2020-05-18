//
//  GetSpeciesEntitiesWebService.swift
//  RogueOne
//
//

import Foundation

class GetSpeciesEntitiesWebService: SWCategoriesWebService<SWEntitiesRequest, SpeciesEntitiesResponse> {
  override func responseFromData(_ data: Data) throws -> SpeciesEntitiesResponse {
    return try newJSONDecoder().decode(SpeciesEntitiesResponse.self,
                                       from: data)
  }
}
