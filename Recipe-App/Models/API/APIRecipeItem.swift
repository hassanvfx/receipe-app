//
//  ResponseRecipe.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import Foundation

struct APIRecipeItem: Identifiable, Decodable {
    let id: String?
    let name: String?
    let cuisine: String?
    
    let photoLargeURLString: String?
    let photoSmallURLString: String?
    let sourceURLString: String?
    let youtubeURLString: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        
        case photoLargeURLString = "photo_url_large"
        case photoSmallURLString = "photo_url_small"
        case sourceURLString = "source_url"
        case youtubeURLString = "youtube_url"
    }

}

extension APIRecipeItem {
  var isValid: Bool {
      name != nil && cuisine != nil && uuid != nil
  }
}

extension APIRecipeItem {
    var uuid: UUID? {
        UUID(uuidString: id ?? "")
    }
}
