//
//  People.swift
//  BabyYoda
//
//  Created by Dhaval Shah on 5/3/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation


//{
//  "name": "R2-D2",
//  "height": "96",
//  "mass": "32",
//  "hair_color": "n/a",
//  "skin_color": "white, blue",
//  "eye_color": "red",
//  "birth_year": "33BBY",
//  "gender": "n/a",
//  "homeworld": "http://swapi.dev/api/planets/8/",
//  "films": [
//  "http://swapi.dev/api/films/1/",
//  "http://swapi.dev/api/films/2/",
//  "http://swapi.dev/api/films/3/",
//  "http://swapi.dev/api/films/4/",
//  "http://swapi.dev/api/films/5/",
//  "http://swapi.dev/api/films/6/"
//  ],
//  "species": [
//  "http://swapi.dev/api/species/2/"
//  ],
//  "vehicles": [],
//  "starships": [],
//  "created": "2014-12-10T15:11:50.376000Z",
//  "edited": "2014-12-20T21:17:50.311000Z",
//  "url": "http://swapi.dev/api/people/3/"
//}


// MARK: - People
class People: Codable {
  let name, height, mass, hairColor: String
  let skinColor, eyeColor, birthYear, gender: String
  let homeworld: String
  let films, species, vehicles, starships: [String]
  let created, edited: String
  let url: String

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case height = "height"
    case mass = "mass"
    case hairColor = "hair_color"
    case skinColor = "skin_color"
    case eyeColor = "eye_color"
    case birthYear = "birth_year"
    case gender = "gender"
    case homeworld = "homeworld"
    case films = "films"
    case species = "species"
    case vehicles = "vehicles"
    case starships = "starships"
    case created = "created"
    case edited = "edited"
    case url = "url"
  }

  init(name: String, height: String, mass: String, hairColor: String, skinColor: String, eyeColor: String, birthYear: String, gender: String, homeworld: String, films: [String], species: [String], vehicles: [String], starships: [String], created: String, edited: String, url: String) {
    self.name = name
    self.height = height
    self.mass = mass
    self.hairColor = hairColor
    self.skinColor = skinColor
    self.eyeColor = eyeColor
    self.birthYear = birthYear
    self.gender = gender
    self.homeworld = homeworld
    self.films = films
    self.species = species
    self.vehicles = vehicles
    self.starships = starships
    self.created = created
    self.edited = edited
    self.url = url
  }
}
