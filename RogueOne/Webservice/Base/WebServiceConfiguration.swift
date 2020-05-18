//
//  WebServiceConfiguration.swift
//  RogueOne
//
//

import Foundation

struct WebServiceConfiguration {
  let baseURL: URL
  let caller: SWWebServiceCaller
  let processingQueue: DispatchQueue
  let callBackQueue: DispatchQueue

  init(baseURL: URL,
       caller: SWWebServiceCaller,
       processingQueue: DispatchQueue = .main,
       callBackQueue: DispatchQueue = .main) {
    self.baseURL = baseURL
    self.caller = caller
    self.processingQueue = processingQueue
    self.callBackQueue = callBackQueue
  }
}

extension WebServiceConfiguration {

  static private let processingQueue = DispatchQueue(label: "com.RogueOne.WebService",
                                                     qos: .userInitiated,
                                                     attributes: [])

  static private let baseURL = URL(string: "https://swapi.dev/api")!

  static func `default`() -> WebServiceConfiguration {
    return WebServiceConfiguration(baseURL: WebServiceConfiguration.baseURL,
                                   caller: SWWebServiceCaller(),
                                   processingQueue: processingQueue)
  }
}
