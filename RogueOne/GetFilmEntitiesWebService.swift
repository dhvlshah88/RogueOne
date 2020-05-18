//
//  GetFilmEntitiesWebService.swift
//  RogueOne
//
//

import Foundation

class GetFilmEntitiesWebService: SWCategoriesWebService<SWEntitiesRequest, FilmEntitiesResponse> {
  override func responseFromData(_ data: Data) throws -> FilmEntitiesResponse {
    return try newJSONDecoder().decode(FilmEntitiesResponse.self,
                                       from: data)
  }
}
