//
//  Constants.swift
//  RogueOne
//
//

import Foundation

typealias Entities = [SWEntity]
typealias Peoples = [People]
typealias Films = [Film]
typealias SpeciesArray = [Species]
typealias Planets = [Planet]
typealias Vehicles = [Vehicle]
typealias Starships = [Starship]
typealias PeoplesClosure = (Peoples) -> Void
typealias FailureClosure = (APIError) -> Void
typealias BoolClosure = (Bool) -> Void
typealias VoidClosure = () -> Void
typealias SWEntitiesResponseClosure = (SWEntitiesResponse) -> Void
typealias EntitiesClosure = (Entities?) -> Void
