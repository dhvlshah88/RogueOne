//
//  SWEntitiesResponse.swift
//  RogueOne
//
//

import Foundation

// MARK:- SWEntitiesResponse
class SWEntitiesResponse: Response, Decodable {
  var count: Int
  var next: String
  var previous: String
  var result: Entities {
    return []
  }

  private enum CodingKeys: String, CodingKey {
    case count, next, previous
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    count = try container.decode(Int.self, forKey: .count)
    next = try container.decodeIfPresent(String.self, forKey: .next) ?? ""
    previous = try container.decodeIfPresent(String.self, forKey: .previous) ?? ""
  }
}

// MARK:- PeopleEntitiesResponse
class PeopleEntitiesResponse: SWEntitiesResponse {
  var _results: Peoples = []

  override var result: Entities {
    return _results
  }

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    _results = try container.decode(Peoples.self, forKey: .results)
    try super.init(from: decoder)
  }
}

// MARK:- FilmEntitiesResponse
class FilmEntitiesResponse: SWEntitiesResponse {
  var _results: Films = []

  override var result: Entities {
    return _results
  }

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    _results = try container.decode(Films.self, forKey: .results)
    try super.init(from: decoder)
  }
}

// MARK:- PlanetEntitiesResponse
class PlanetEntitiesResponse: SWEntitiesResponse {
  var _results: Planets = []

  override var result: Entities {
    return _results
  }

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    _results = try container.decode(Planets.self, forKey: .results)
    try super.init(from: decoder)
  }
}

// MARK:- VehiclesEntitiesResponse
class VehiclesEntitiesResponse: SWEntitiesResponse {
  var _results: Vehicles = []

  override var result: Entities {
    return _results
  }

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    _results = try container.decode(Vehicles.self, forKey: .results)
    try super.init(from: decoder)
  }
}

// MARK:- SpeciesEntitiesResponse
class SpeciesEntitiesResponse: SWEntitiesResponse {
  var _results: SpeciesArray = []

  override var result: Entities {
    return _results
  }

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    _results = try container.decode(SpeciesArray.self, forKey: .results)
    try super.init(from: decoder)
  }
}

// MARK:- StarshipEntitiesResponse
class StarshipEntitiesResponse: SWEntitiesResponse {
  var _results: Starships = []

  override var result: Entities {
    return _results
  }

  private enum CodingKeys: String, CodingKey {
    case results
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    _results = try container.decode(Starships.self, forKey: .results)
    try super.init(from: decoder)
  }
}
