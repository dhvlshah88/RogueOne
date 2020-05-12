//
//  SWCategoriesWebService.swift
//  RogueOne
//
//

import Foundation

class SWCategoryRequest: Request {
  var type: SWEntityType?
  
  convenience init(type: SWEntityType) {
    self.init()
    self.type = type
  }
}

class SWCategoriesWebService<Request: AnyObject, Response: AnyObject>: WebService<SWCategoryRequest, Response> {
  override func urlRequest(with request: SWCategoryRequest) -> URLRequest {
    if let type = request.type {
      return URLRequest(url: configuration.baseURL.appendingPathComponent(type.rawValue))
    }

    return URLRequest(url: configuration.baseURL)
  }
}

