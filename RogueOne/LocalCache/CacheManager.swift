//
//  CacheManager.swift
//  RogueOne
//
//

import Foundation

class CacheManager {
  private(set) var categoryMap: [SWEntityType: [String: SWEntity]] = [:]

  init() {
    configureCategoryMap()
  }

  private func configureCategoryMap() {
    categoryMap[.people] = [String: People]()
    categoryMap[.films] = [String: Film]()
    categoryMap[.planets] = [String: Planet]()
    categoryMap[.species] = [String: Species]()
    categoryMap[.starships] = [String: Starship]()
    categoryMap[.vehicles] = [String: Vehicle]()
  }

  func addPeoples(_ peoples: Peoples) {
    if peoples.isEmpty {
      return
    }

    var peoplesMap = categoryMap[.people, default: [:]]
    peoples.forEach { peoplesMap[$0.url] = $0 }
    categoryMap[.people] = peoplesMap
  }

  func addFilms(_ films: Films) {
    if films.isEmpty {
      return
    }

    var filmsMap = categoryMap[.films, default: [:]]
    films.forEach { filmsMap[$0.url] = $0 }
    categoryMap[.films] = filmsMap
  }

  func getEntityLocally(url: String, type: SWEntityType) -> SWEntity? {
    switch type {
    case .people:
      return getPeopleLocally(url: url)
    case .films:
      return getFilmLocally(url: url)
    default:
      return nil
    }
  }

  func getPeopleLocally(url: String) -> People? {
    guard let map = categoryMap[.people],
      let people = map[url] as? People else {
      return nil
    }
    return people
  }

  func getFilmLocally(url: String) -> Film? {
    guard let map = categoryMap[.films],
      let film = map[url] as? Film else {
        return nil
    }
    return film
  }

  var count: Int {
    var _count = 0
    categoryMap.forEach({(_, value) in
      _count += value.count
    })
    return _count
  }
}
