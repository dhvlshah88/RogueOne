//
//  APIManager.swift
//  RogueOne
//
//

import Foundation

class WebService<Request: AnyObject, Response: AnyObject> {
  typealias SuccessClosure = (Response) -> Void
  
  let configuration: WebServiceConfiguration
  
  var httpMethod: HTTP.Method {
    return .get
  }
  
  var url: URL {
    return configuration.baseURL
  }
  
  required init(configuration: WebServiceConfiguration) {
    self.configuration = configuration
  }
  
  class func `default`() -> Self {
    return self.init(configuration: WebServiceConfiguration.default())
  }
  
  func urlRequest(with request: Request) -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = httpMethod.rawValue
    urlRequest.setValue(HTTP.HeaderValue.applicationJSON, forHTTPHeaderField: HTTP.HeaderName.contentType)
    
    if httpMethod != .get {
      urlRequest.httpBody = httpBody(with: request)
    }
    return urlRequest
  }
  
  func httpBody(with request: Request) -> Data? {
    return nil
  }
  
  func responseFromData(_ data: Data) throws -> Response {
    throw APIError(name: "Abstract method Error", message: "Abstract method, must be overridden")
  }
  
  func call(request: Request,
            success: @escaping SuccessClosure,
            failure: @escaping FailureClosure,
            queue: DispatchQueue? = nil) {
    let urlRequest = self.urlRequest(with: request)
    
    configuration.caller.start(
      request: urlRequest,
      queue: queue ?? configuration.processingQueue) { [weak self] (result: WebServiceResult<Data>) in
        self?.process(result,
                      success: success,
                      failure: failure)
    }
  }
  
  
  private func process(_ result: WebServiceResult<Data>,
                       success: @escaping SuccessClosure,
                       failure: @escaping FailureClosure) {
    switch result {
    case .failure(let error):
      print(String(describing: error.localizedDescription))
      let apiError = APIError(message: error.localizedDescription)
      dispatchOnCallbackQueue(failure(apiError))
    case .success(let data):
      do {
        let response = try responseFromData(data)
        dispatchOnCallbackQueue(success(response))
      } catch let DecodingError.dataCorrupted(context) {
        print(context)
      } catch let DecodingError.keyNotFound(key, context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.valueNotFound(value, context) {
        print("Value '\(value)' not found: \(context.debugDescription)")
        print("codingPath:", context.codingPath)
      } catch let DecodingError.typeMismatch(type, context)  {
        var message = "Type '\(type)' mismatch: \(context.debugDescription) \n"
        message += "codingPath: \(context.codingPath)"
        let apiError = APIError(message: message)
        dispatchOnCallbackQueue(failure(apiError))
      } catch let error {
        let apiError = APIError(message: error.localizedDescription)
        dispatchOnCallbackQueue(failure(apiError))
      }
    }
  }
  
  private func dispatchOnCallbackQueue(_ completion: @escaping @autoclosure () -> Void) {
    configuration.callBackQueue.async {
      completion()
    }
  }
}

extension WebService {
  func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }
}