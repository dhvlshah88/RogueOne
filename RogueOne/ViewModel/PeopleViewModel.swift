//
//  PeopleViewModel.swift
//  RogueOne
//
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

protocol ViewModel {
  var imageString: String { get }
  var title: String { get }
  var body: [String] { get }
  var relatedViewModelPerEntityType: [SWEntityType: [RelatedEntityViewModel]] { get }
}

struct PeopleViewModel: ViewModel {
  private static let heightMetric: Float = 2.54
  private let people: People
  private let cacheManager: CacheManager

  init(_ people: People, _ cacheManager: CacheManager) {
    self.people = people
    self.cacheManager = cacheManager
  }
}

extension PeopleViewModel {

  var imageString: String {
    let urlComponents = people.url.split(separator: "/").filter ({ !$0.isEmpty })
    guard let imageIndex = urlComponents.last else { return "" }
    return "people-\(imageIndex)"
  }

  var title: String {
    return people.name
  }

  var body: [String] {
    var body = [String]()
    body.append(heightInInches)
    body.append(weightInKG)
    body.append(contentsOf: appearance)
    return body
  }

  var relatedViewModelPerEntityType: [SWEntityType: [RelatedEntityViewModel]] {
    return [.films: createFilmRelatedViewModel()]
  }

  private var appearance: [String] {
    var appearances: [String] = []
    if let hairColor = formattedHairColor {
      appearances.append(hairColor)
    }
    if let eyeColor = formattedEyeColor {
      appearances.append(eyeColor)
    }
    if let skinColor = formattedSkinColor {
      appearances.append(skinColor)
    }
    return appearances
  }

  private var formattedHairColor: String? {
    if people.hairColor != "n/a" && !people.hairColor.isEmpty {
      return "Hair Color - \(people.hairColor.capitalized)"
    }
    return nil
  }

  private var formattedEyeColor: String? {
    if people.eyeColor != "n/a" && !people.eyeColor.isEmpty {
      return "Eye Color - \(people.eyeColor.capitalized)"
    }
    return nil
  }

  private var formattedSkinColor: String? {
    if people.skinColor != "n/a" && !people.skinColor.isEmpty {
      let colors = people.skinColor.split(separator: ",")
      var skinColorApperance = "Skin Color - "
      if colors.count == 1 {
        skinColorApperance += "\(people.skinColor.capitalized)"
      } else {
        skinColorApperance += colors.map { $0.capitalized }.joined(separator: ",")
      }
      return skinColorApperance
    }
    return nil
  }

  var heightInInches: String {
    return "Height: \(people.height) cm"
  }

  var weightInKG: String {
    return "Weight: \(people.mass) kg"
  }

  private func convertCMToInches(_ value: Double) -> String {
    let formatter = MeasurementFormatter()
    let measurement = Measurement(value: value, unit: UnitLength.inches)
    return formatter.string(from: measurement)
  }

  private func createFilmRelatedViewModel() -> [RelatedEntityViewModel] {
    var relatedModels = [RelatedEntityViewModel]()
    people.films.forEach {
      relatedModels.append(RelatedEntityViewModel(url: $0,
                                                  type: .films,
                                                  cacheManager: cacheManager))
    }
    return relatedModels
  }
}
