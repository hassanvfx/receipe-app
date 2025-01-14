//
//  APIRecipesRespnse.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

import Foundation

/// This struct holds the payload response from the server, it is intended to contain other future params related to the transport like pagination
struct APIRecipes: Decodable {
    let recipes: [APIRecipeItem]
}
