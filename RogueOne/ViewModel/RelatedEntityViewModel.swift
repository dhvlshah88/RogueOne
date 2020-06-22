//
//  RelatedEntityViewModel.swift
//  RogueOne
//
//

import Foundation

struct RelatedEntityViewModel {
  private var url: String
  private var entityType: SWEntityType
  private var cacheManager: CacheManager

  init(url: String,
       type: SWEntityType,
       cacheManager: CacheManager) {
    self.url = url
    self.entityType = type
    self.cacheManager = cacheManager
  }
}

extension RelatedEntityViewModel {
  var title: String {
    guard let entity = entity else { return "Unknown" }
    return entity.entityName
  }

  var imageName: String {
    var entityUrl = url
    if entityUrl.last == "/" {
      entityUrl.removeLast(1)
    }
    let components = entityUrl.components(separatedBy: "/")
    guard let last = components.last, !last.isEmpty else { return "" }
    return "\(entityType.singularValue)-\(last)"
  }

  var entity: SWEntity? {
    return cacheManager.getEntityLocally(url: url, type: entityType)
  }
}
