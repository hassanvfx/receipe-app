//
//  Recipe.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import Foundation

/// This struct is the local representation for a recipe
struct Recipe: Decodable {
    let uuid: UUID
    let name: String
    let cuisine: String
    
    let photoLargeURL: URL?
    let photoSmallURL: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
}

/// Conformance to the Identifiable protocol through the uuid
extension Recipe: Identifiable {
    var id: String { uuid.uuidString }
}

/// This failable initializer allows to map an APIRecipeItem into the local Recipe struct
extension Recipe{
    init?(apiRecipe:APIRecipeItem){
        guard apiRecipe.isValid,
              let uuid = apiRecipe.uuid else {
            return nil
        }
        
        self.uuid = uuid
        self.name = apiRecipe.name ?? ""
        self.cuisine = apiRecipe.cuisine ?? ""
        self.photoLargeURL = URL(string: apiRecipe.photoLargeURLString ?? "")
        self.photoSmallURL = URL(string: apiRecipe.photoLargeURLString ?? "")
        self.sourceURL = URL(string: apiRecipe.photoLargeURLString ?? "")
        self.youtubeURL = URL(string: apiRecipe.photoLargeURLString ?? "")
    }
}



