//
//  Starship.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/4/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

// MARK: - Starship
class Starship: SWEntity {
  let name, model, manufacturer, costInCredits: String
  let length, maxAtmospheringSpeed, crew, passengers: String
  let cargoCapacity, consumables, hyperdriveRating, mglt: String
  let starshipClass: String
  let pilots, films: [String]
  var created, edited: String
  var url: String

  var entityName: String {
    return name
  }

  var type: SWEntityType {
    return .starships
  }

  enum CodingKeys: String, CodingKey {
    case name, model, manufacturer
    case costInCredits = "cost_in_credits"
    case length
    case maxAtmospheringSpeed = "max_atmosphering_speed"
    case crew, passengers
    case cargoCapacity = "cargo_capacity"
    case consumables
    case hyperdriveRating = "hyperdrive_rating"
    case mglt = "MGLT"
    case starshipClass = "starship_class"
    case pilots, films, created, edited, url
  }
}
