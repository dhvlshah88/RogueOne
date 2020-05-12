//
//  SWEntity.swift
//  RogueOne
//
//

import Foundation

protocol SWEntity: Decodable {
  var type: SWEntityType { get }
  var entityName: String { get }
}
