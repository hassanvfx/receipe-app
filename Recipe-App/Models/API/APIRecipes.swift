//
//  APIRecipesRespnse.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

import Foundation

struct APIRecipes: Decodable {
    let recipes: [APIRecipeItem]
}
