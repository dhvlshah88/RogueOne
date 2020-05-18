//
//  SWCategoriesWebService.swift
//  RogueOne
//
//

import Foundation

class SWEntitiesRequest: Request {
  var type: SWEntityType?
  var nextPageUrl: URL?

  convenience init(type: SWEntityType) {
    self.init()
    self.type = type
  }

  convenience init(_ urlString: String) {
    self.init()
    nextPageUrl = URL(string: urlString)
  }
}

class SWCategoriesWebService<Request: AnyObject, Response: AnyObject>: WebService<SWEntitiesRequest, Response> {
  override func urlRequest(with request: SWEntitiesRequest) -> URLRequest {
    if let type = request.type {
      return URLRequest(url: configuration.baseURL.appendingPathComponent(type.rawValue))
    }

    if let nextPageUrl = request.nextPageUrl {
      return URLRequest(url: nextPageUrl)
    }

    return URLRequest(url: configuration.baseURL)
  }
}
