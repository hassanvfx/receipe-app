//
//  RecipeItemView.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    var active = false

    var body: some View {
        HStack {
            RecipeImageView(recipe: recipe)

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bgColor)
      
    }
}
extension RecipeRowView {
    var bgColor:Color{
        active ? Style.Colors.active : Style.Colors.inactive
    }
}
