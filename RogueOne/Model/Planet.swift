//
//  Planet.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/4/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

// MARK: - Planet
class Planet: SWEntity {
  let name, rotationPeriod, orbitalPeriod, diameter: String
  let climate, gravity, terrain, surfaceWater: String
  let population: String
  let residents, films: [String]
  let created, edited: String
  let url: String

  var entityName: String {
    return name
  }
  
  var type: SWEntityType {
    return .planets
  }

  enum CodingKeys: String, CodingKey {
    case name
    case rotationPeriod = "rotation_period"
    case orbitalPeriod = "orbital_period"
    case diameter, climate, gravity, terrain
    case surfaceWater = "surface_water"
    case population, residents, films, created, edited, url
  }
}

