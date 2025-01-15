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
        isLoading = true
        apiError = nil
    }
    func endLoading(){
        isLoading = false
    }
}


extension RecipesViewModel {
    
    func fetchRecipes() async{
        guard !isLoading else { return }
        guard recipes.isEmpty else { return }
        
        beginLoading()
        
        do {
            let response = try await Services.api.fetchRecipes()
            set(apiRecipes: response.recipes)
        } catch {
            apiError = error as? APIService.Failure ?? APIService.Failure.unknown
            
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
