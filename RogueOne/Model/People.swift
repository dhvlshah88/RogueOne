//
//  People.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/3/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

// MARK: - People
class People: SWEntity {
  let name, height, mass, hairColor: String
  let skinColor, eyeColor, birthYear, gender: String
  let homeworld: String
  let films, species, vehicles, starships: [String]
  let created, edited: String
  let url: String

  var entityName: String {
    return name
  }

  var type: SWEntityType {
    return .people
  }

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case height = "height"
    case mass = "mass"
    case hairColor = "hair_color"
    case skinColor = "skin_color"
    case eyeColor = "eye_color"
    case birthYear = "birth_year"
    case gender = "gender"
    case homeworld = "homeworld"
    case films = "films"
    case species = "species"
    case vehicles = "vehicles"
    case starships = "starships"
    case created = "created"
    case edited = "edited"
    case url = "url"
  }
}
