//
//  ResponseSerializer.swift
//  RogueOne
//
//

import Foundation

struct ResponseSerializer<T> {
  typealias SerializedResponse = (Data?, HTTPURLResponse?, Error?) -> Result<T, Error>
  var serializedResponse: SerializedResponse
}
