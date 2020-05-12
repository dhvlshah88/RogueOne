//
//  HTTPConstants.swift
//  RogueOne
//
//

enum HTTP {
  enum Method: String {
    case get = "GET"
  }

  enum HeaderName {
    static let contentType = "Content-Type"
  }

  enum HeaderValue {
    static let applicationJSON = "application/json"
  }
}
