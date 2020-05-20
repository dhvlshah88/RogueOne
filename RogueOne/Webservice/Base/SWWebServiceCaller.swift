//
//  SWWebServiceCaller.swift
//  RogueOne
//
//

import Foundation
import Network

class SWWebServiceCaller {

  typealias WebServiceCallerCompletion = (_ result: WebServiceResult<Data>) -> Void

  static let session: URLSession = {
    let urlSessionConfiguration = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: urlSessionConfiguration)
    return urlSession
  }()

  private(set) var dataTask: URLSessionDataTask?

  static func dataResponseSerializer() -> ResponseSerializer<Data> {
    return ResponseSerializer { data, response, error in
      guard error == nil else {
        return .failure(APIError(message: error!.localizedDescription))
      }

      if let response = response,
        [204, 205].contains(response.statusCode) {
        return .success(Data())
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
    dataTask = SWWebServiceCaller.session.dataTask(with: request) { (data, response, error) in
      let result = SWWebServiceCaller.dataResponseSerializer().serializedResponse(data, response as? HTTPURLResponse, error)
      queue.async {
        completion(result)
      }
    }
    dataTask!.resume()
  }
}
