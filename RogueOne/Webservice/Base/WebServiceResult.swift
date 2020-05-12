//
//  WebServcieResult.swift
//  RogueOne
//
//

public enum WebServiceResult<Value> {
  case success(Value)
  case failure(Error)
}
