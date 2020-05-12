//
//  ResponseSerializer.swift
//  RogueOne
//
//

import Foundation

struct ResponseSerializer<T> {
  var serializedResponse: (Data?, HTTPURLResponse?, Error?) -> WebServiceResult<T>
}
