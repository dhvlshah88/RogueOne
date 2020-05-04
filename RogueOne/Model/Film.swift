//
//  Film.swift
//  BabyYoda
//
//  Created by Dhaval Shah on 5/4/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

// MARK: - Film
class Film: Codable {
  let title: String
  let episodeID: Int
  let openingCrawl, director, producer, releaseDate: String
  let characters, planets, starships, vehicles: [String]
  let species: [String]
  let created, edited: String
  let url: String

  enum CodingKeys: String, CodingKey {
    case title = "title"
    case episodeID = "episode_id"
    case openingCrawl = "opening_crawl"
    case director = "director"
    case producer = "producer"
    case releaseDate = "release_date"
    case characters, planets, starships, vehicles, species, created, edited, url
  }

  init(title: String, episodeID: Int, openingCrawl: String, director: String, producer: String, releaseDate: String, characters: [String], planets: [String], starships: [String], vehicles: [String], species: [String], created: String, edited: String, url: String) {
    self.title = title
    self.episodeID = episodeID
    self.openingCrawl = openingCrawl
    self.director = director
    self.producer = producer
    self.releaseDate = releaseDate
    self.characters = characters
    self.planets = planets
    self.starships = starships
    self.vehicles = vehicles
    self.species = species
    self.created = created
    self.edited = edited
    self.url = url
  }
}
