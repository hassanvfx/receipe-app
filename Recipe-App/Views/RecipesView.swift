//
//  ContentView.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

import SwiftUI

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                if let selectedRecipe = viewModel.selectedRecipe {
                    RecipeDetailView(recipe: selectedRecipe)
                } else{
                    nonSelectedRecipeView()
                }
                
                recipesList()
            }
           
        }
        .onAppear(perform: fetchRecipes)
    }
}

extension RecipesView {
    @ViewBuilder
    func nonSelectedRecipeView() -> some View {
        Text("Select a recipe")
            .font(.headline)
            .padding(Style.padding * 2)
            .frame(maxWidth: .infinity)
    }
    
}

extension RecipesView {
    @ViewBuilder
    func recipesList() -> some View {
        List(viewModel.recipes) { recipe in
            Button(action: { viewModel.select(recipe: recipe) }){
                RecipeRowView(recipe: recipe, active: recipe.id == viewModel.selectedRecipe?.id)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.loadRecipes()
        }
        .navigationTitle("Recipes")
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
            if let apiError = viewModel.apiError {
                Text(apiError.localizedDescription)
                    .foregroundColor(.red)
                    .padding(Style.padding)
            }
        }
    }
}


extension RecipesView {
    func fetchRecipes() {
        Task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    RecipesView()
}
