//
//  RecipeItemView.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    @State private var image: UIImage?

    var body: some View {
        HStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
      
            }

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear(perform: fetchImage)
    }

    private func fetchImage()  {
        Task {
            guard let url = recipe.photoSmallURL,
                  let image =  await  Services.images.fetch(from: url) else {
                self.image = nil
                Services.log.debug("Failed to load image")
                return
            }
            self.image = image
        }
    }
}
