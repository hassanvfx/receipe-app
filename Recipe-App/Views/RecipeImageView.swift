//
//  ImageDisplay.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import SwiftUI

struct RecipeImageView: View {
    enum Size {
        case thumb
        case large
    }
    let recipe: Recipe
    var size: Size = .thumb
    @State private var image: UIImage?
    
    var imageSize:CGSize {
        switch size {
        case .thumb:
            return Style.thumbSize
        case .large:
            return Style.largeSize
        }
    }
    
    var body: some View {
        
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius))
            } else {
                Rectangle()
                    .fill(Style.Colors.inactive)
                    .frame(width: Style.thumbSize.width, height: Style.thumbSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius))
            }
        }
        .onAppear {
            fetchImage()
        }
    }
    
    private func fetchImage() {
        Task {
            
            let url = size == .large ? recipe.photoLargeURL : recipe.photoSmallURL
            
            guard let url = url, let image = await Services.images.fetch(from: url) else {
                self.image = nil
                Services.log.debug("Failed to load image")
                return
            }
            self.image = image
        }
    }
}
