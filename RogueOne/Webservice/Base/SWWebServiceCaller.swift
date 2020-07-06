//
//  SWWebServiceCaller.swift
//  RogueOne
//
//

import Foundation
import Network

class SWWebServiceCaller {
  
  typealias WebServiceCallerCompletion = (_ result: WebServiceResult<Data>) -> Void
  
  private let session: URLSession
  
  init(_ sessionConfiguration: URLSessionConfiguration = .default) {
    session = URLSession(configuration: sessionConfiguration)
  }
  
  private(set) var dataTask: URLSessionDataTask?
  
  static func dataResponseSerializer() -> ResponseSerializer<Data> {
    return ResponseSerializer { data, response, error in
      guard error == nil else {
        return .failure(APIError(message: error!.localizedDescription))
      }
      
      guard let response = response, response.statusCode == 200 else {
        return .failure(APIError(message: "Something went wrong while fetching response from server!"))
      }
      
      guard let validData = data else {
        return .failure(APIError(message: "Data is nil!"))
      }
      
      return .success(validData)
    }
  }
  
  func start(request: URLRequest,
             queue: DispatchQueue,
             completion: @escaping WebServiceCallerCompletion) {
    dataTask = session.dataTask(with: request) { (data, response, error) in
      let result = SWWebServiceCaller.dataResponseSerializer().serializedResponse(data, response as? HTTPURLResponse, error)
      queue.async {
        completion(result)
      }
    }
    dataTask!.resume()
  }
}
