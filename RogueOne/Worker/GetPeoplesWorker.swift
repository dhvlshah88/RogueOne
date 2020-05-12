//
//  GetPeoplesWorker.swift
//  RogueOne
//
//

import Foundation

protocol Fetchable {
  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure)
}

class GetPeoplesWorker: Fetchable {
  lazy var peoplesWebservice = GetPeopleEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure) {
    let request = SWCategoryRequest(type: type)
    peoplesWebservice.call(request: request,
                           success: { (response) in
                            success(response.results)
    },
                           failure: failure)
  }
}

class GetFilmsWorker: Fetchable {
  lazy var filmsWebservice = GetFilmEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure) {
    let request = SWCategoryRequest(type: type)
    filmsWebservice.call(request: request,
                         success: { (response) in
                          success(response.results)
    },
                         failure: failure)
  }
}

class GetVehiclesWorker: Fetchable {
  lazy var vehiclesWebservice = GetVehicleEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure) {
    let request = SWCategoryRequest(type: type)
    vehiclesWebservice.call(request: request,
                            success: { (response) in
                              success(response.results)
    },
                            failure: failure)
  }
}

class GetStarshipsWorker: Fetchable {
  lazy var starshipsWebservice = GetStarshipEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure) {
    let request = SWCategoryRequest(type: type)
    starshipsWebservice.call(request: request,
                             success: { (response) in
                              success(response.results)
    },
                             failure: failure)
  }
}

class GetPlanetsWorker: Fetchable {
  lazy var planetsWebservice = GetPlanetEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure) {
    let request = SWCategoryRequest(type: type)
    planetsWebservice.call(request: request,
                           success: { (response) in
                            success(response.results)
    },
                           failure: failure)
  }
}

class GetSpeciesWorker: Fetchable {
  lazy var speciesWebservice = GetSpeciesEntitiesWebService.default()

  func getEntities(for type: SWEntityType,
                   success: @escaping SWCategoriesClosure,
                   failure: @escaping FailureClosure) {
    let request = SWCategoryRequest(type: type)
    speciesWebservice.call(request: request,
                           success: { (response) in
                            success(response.results)
    },
                           failure: failure)
  }
}

