//
//  SWCategoryResponse.swift
//  RogueOne
//
//

import Foundation

//MARK :- SWCategoryResponse
class SWCategoryResponse: Response, Decodable {
  var count: Int
  var next: String?
  var previous: String?

  private enum CodingKeys: String, CodingKey {
    case count, next, previous
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    count = try container.decode(Int.self, forKey: .count)
    next = try container.decodeIfPresent(String.self, forKey: .next)
    previous = try container.decodeIfPresent(String.self, forKey: .previous)
  }
}

//MARK :- PeopleEntitiesResponse
class PeopleEntitiesResponse: SWCategoryResponse {
  var results: Peoples = []

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decode(Peoples.self, forKey: .results)
    try super.init(from: decoder)
  }
}

//MARK :- FilmEntitiesResponse
class FilmEntitiesResponse: SWCategoryResponse {
  var results: Films = []

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decode(Films.self, forKey: .results)
    try super.init(from: decoder)
  }
}

//MARK :- PlanetEntitiesResponse
class PlanetEntitiesResponse: SWCategoryResponse {
  var results: Planets = []

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decode(Planets.self, forKey: .results)
    try super.init(from: decoder)
  }
}

//MARK :- VehiclesEntitiesResponse
class VehiclesEntitiesResponse: SWCategoryResponse {
  var results: Vehicles = []

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decode(Vehicles.self, forKey: .results)
    try super.init(from: decoder)
  }
}

//MARK :- SpeciesEntitiesResponse
class SpeciesEntitiesResponse: SWCategoryResponse {
  var results: SpeciesArray = []

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decode(SpeciesArray.self, forKey: .results)
    try super.init(from: decoder)
  }
}

//MARK :- StarshipEntitiesResponse
class StarshipEntitiesResponse: SWCategoryResponse {
  var results: Starships = []

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decode(Starships.self, forKey: .results)
    try super.init(from: decoder)
  }
}
