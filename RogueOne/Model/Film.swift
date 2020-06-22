//
//  Film.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/4/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation

// MARK: - Film
class Film: NSObject, SWEntity {
  @objc dynamic let title: String
  let episodeID: Int
  let openingCrawl, director, producer, releaseDate: String
  let characters, planets, starships, vehicles: [String?]
  let species: [String?]
  let created, edited: String
  let url: String

  var entityName: String {
    return title
  }

  var type: SWEntityType {
    return .films
  }

  enum CodingKeys: String, CodingKey {
    case title = "title"
    case episodeID = "episode_id"
    case openingCrawl = "opening_crawl"
    case director = "director"
    case producer = "producer"
    case releaseDate = "release_date"
    case characters, planets, starships, vehicles, species, created, edited, url
  }
}
