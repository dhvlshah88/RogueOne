//
//  ResponseSerializer.swift
//  RogueOne
//
//

import Foundation

struct ResponseSerializer<T> {
  typealias SerializedResponse = (Data?, HTTPURLResponse?, Error?) -> WebServiceResult<T>
  var serializedResponse: SerializedResponse
}
