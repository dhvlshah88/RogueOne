//
//  SWCategoryType.swift
//  RogueOne
//
//

import Foundation

enum SWEntityType: String, CaseIterable, CustomStringConvertible {
  case people
  case planets
  case films
  case species
  case vehicles
  case starships

  typealias AllCases = [SWEntityType]

  var singularValue: String {
    switch self {
    case .planets:
      return "planet"
    case .films:
      return "film"
    case .vehicles:
      return "vehicle"
    case .starships:
      return "starship"
    default:
      return self.rawValue
    }
  }

  var description: String {
    if self == .people {
      return "Characters"
    }
    return self.rawValue.capitalized
  }
}
