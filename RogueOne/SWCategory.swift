//
//  SWCategory.swift
//  BabyYoda
//
//  Created by Dhaval Shah on 5/3/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

enum SWCategory: String, CaseIterable, CustomStringConvertible {
  case people
  case planets
  case films
  case species
  case vehicles
  case starships

  typealias AllCases = [SWCategory]

  var description: String {
    return self.rawValue.capitalized
  }

  var emoji: String {
    switch self {
    case .films:
      return "🎥"
    default:
      return "🤷‍♂️"
    }
  }
}
