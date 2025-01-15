//
//  Seed.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import Foundation
enum Seed {
    static let recipe = Recipe(
        uuid: UUID(uuidString: "11111111-2222-3333-4444-555555555555") ?? UUID(),
        name: "Spaghetti Carbonara",
        cuisine: "Italian",
        photoLargeURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
        photoSmallURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
        sourceURL: URL(string: "https://example.com/carbonara-recipe"),
        youtubeURL: URL(string: "https://youtube.com/watch?v=YOUR_VIDEO_ID")
    )
}
