//
//  Vehicle.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/4/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

// MARK: - Vehicle
class Vehicle: SWEntity {
  let name, model, manufacturer, costInCredits: String
  let length, maxAtmospheringSpeed, crew, passengers: String
  let cargoCapacity, consumables, vehicleClass: String
  let pilots: [String?]
  let films: [String]
  let created, edited: String
  let url: String

  var entityName: String {
    return name
  }

  var type: SWEntityType {
    return .vehicles
  }

  enum CodingKeys: String, CodingKey {
    case name, model, manufacturer
    case costInCredits = "cost_in_credits"
    case length
    case maxAtmospheringSpeed = "max_atmosphering_speed"
    case crew, passengers
    case cargoCapacity = "cargo_capacity"
    case consumables
    case vehicleClass = "vehicle_class"
    case pilots, films, created, edited, url
  }
}
