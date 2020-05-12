//
//  Species.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/4/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

// MARK: - Species
class Species: SWEntity {
  let name, classification, designation, averageHeight: String
  let skinColors, hairColors, eyeColors, averageLifespan: String
  let homeworld: String
  let language: String
  let people, films: [String?]
  let created, edited: String
  let url: String

  var entityName: String {
    return name
  }

  var type: SWEntityType {
    return .species
  }

  enum CodingKeys: String, CodingKey {
    case name, classification, designation
    case averageHeight = "average_height"
    case skinColors = "skin_colors"
    case hairColors = "hair_colors"
    case eyeColors = "eye_colors"
    case averageLifespan = "average_lifespan"
    case homeworld, language, people, films, created, edited, url
  }
}
