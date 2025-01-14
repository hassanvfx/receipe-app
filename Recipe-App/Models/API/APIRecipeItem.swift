//
//  ResponseRecipe.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import Foundation

/// This struct allows to directly map the responses from the server. See Recipe Struct for the local representation

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
/// This extension allows to quickly determine if the item is valid in the local context and can be mapped into it
extension APIRecipeItem {
  var isValid: Bool {
      name != nil && cuisine != nil && uuid != nil
  }
}

/// Handy getter that optionally mas the expected uuid received from the server
extension APIRecipeItem {
    var uuid: UUID? {
        UUID(uuidString: id ?? "")
    }
}
