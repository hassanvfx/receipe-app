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
            List(viewModel.recipes) { recipe in
                RecipeRowView(recipe: recipe)
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
                        .padding()
                }
            }
        }
        .onAppear(perform: loadRecipes)
    }
}

extension RecipesView {
    func loadRecipes() {
        Task {
            await viewModel.loadRecipes()
        }
    }
}

#Preview {
    RecipesView()
}
