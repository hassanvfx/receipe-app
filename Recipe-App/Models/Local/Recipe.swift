//
//  Recipe.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import Foundation

struct Recipe: Decodable {
    let uuid: UUID
    let name: String
    let cuisine: String
    
    let photoLargeURL: URL?
    let photoSmallURL: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
}

extension Recipe: Identifiable {
    var id: String { uuid.uuidString }
}

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



