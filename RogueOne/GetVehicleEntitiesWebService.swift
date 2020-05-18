//
//  GetVehicleEntitiesWebService.swift
//  RogueOne
//
//

import Foundation

class GetVehicleEntitiesWebService: SWCategoriesWebService<SWEntitiesRequest, VehiclesEntitiesResponse> {
  override func responseFromData(_ data: Data) throws -> VehiclesEntitiesResponse {
    return try newJSONDecoder().decode(VehiclesEntitiesResponse.self,
                                       from: data)
  }
}
