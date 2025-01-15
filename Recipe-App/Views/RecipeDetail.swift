//
//  RecipeDetail.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            RecipeImageView(recipe: recipe, size: .large)
                .padding(Style.padding)

            VStack(alignment: .leading, spacing: Style.padding) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let sourceURL = recipe.sourceURL {
                  
                    Link(destination: sourceURL, label: { Text("View Source") })
                }
                
                if let youtubeURL = recipe.youtubeURL {
                    Link(destination: youtubeURL, label: { Text("YouTube Video") })
                }
            }
            .padding(.trailing, Style.padding)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .id(recipe.id) // this ensures we reload the images when the recipe changes by invalidting the DOM
      
    }
}

#Preview {
    RecipeDetailView(recipe: Seed.recipe)
}
