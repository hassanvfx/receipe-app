//
//  RecipesViewModel.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import SwiftUI

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var apiError: APIService.Failure?
    @Published var apiMessage: String?
    @Published var isLoading: Bool = false
}

extension RecipesViewModel {
    
    func beginLoading(){
        Services.log.info("RecipesViewModel: Begin loading")
        isLoading = true
        apiError = nil
    }
    func endLoading(){
        Services.log.info("RecipesViewModel: End loading")
        isLoading = false
    }
}


extension RecipesViewModel {
    
    func fetchRecipes() async{
        guard !isLoading else {
            Services.log.info("RecipesViewModel: Already loading")
            return
        }
        guard recipes.isEmpty else {
            Services.log.info( "RecipesViewModel: Already fetched")
            return
        }
        
        beginLoading()
        
        do {
            let response = try await Services.api.fetchRecipes()
            
            Services.log.info("RecipesViewModel: Fetched \(response.recipes.count) recipes")
            
            set(apiRecipes: response.recipes)
            
        } catch {
            apiError = error as? APIService.Failure ?? APIService.Failure.unknown
            
            Services.log.error(apiError.debugDescription)
            
            set(apiRecipes: [])
        }
        
        endLoading()
    }
}

extension RecipesViewModel {
    
    func set(apiRecipes:[APIRecipeItem]){
        self.recipes = apiRecipes.map{ Recipe(apiRecipe: $0) }.compactMap{ $0 }
    }
}
