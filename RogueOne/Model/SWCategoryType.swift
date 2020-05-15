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

  var description: String {
    if self == .people {
      return "Characters"
    }
    return self.rawValue.capitalized
  }
}
