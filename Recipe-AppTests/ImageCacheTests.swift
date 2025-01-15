//
//  ImageCacheTests.swift
//  Recipe-AppTests
//
//  Created by Hassan on 14/01/25.
//

import Testing
import Foundation
@testable import Recipe_App

struct ImageCacheTests {

   
    private let imageCache = ImageCache()
    private let imageURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg")!
    
    @Test
    func testFetchImage_withValidURL_shouldReturnNonNilImage() async throws {
        // Clear the cache before starting (to ensure a fresh state).
        await imageCache.removeAllCachedImages()
        let fetchedImage = await imageCache.fetch(from: imageURL)
        #expect(fetchedImage != nil, "Expected a non-nil image for a valid URL.")
    }
    
    @Test
    func testFetchImage_withInvalidURL_shouldReturnNilImage() async throws {
       
        await imageCache.removeAllCachedImages()
        let invalidURL = URL(string: "https://invalid.example.com/nonexistent.jpg")!
        let fetchedImage = await imageCache.fetch(from: invalidURL)
        #expect(fetchedImage == nil, "Expected `nil` for an invalid URL.")
    }
    
    @Test
    func testRemoveAllCachedImages_shouldEmptyTheCacheFolder() async throws {
        _ = await imageCache.fetch(from: imageURL)
        
        // Writing to disk is asynchronous by design so we just need to wait a second to make sure it will be removed
        try await Task.sleep(nanoseconds: 1_000_000_000)
        await imageCache.removeAllCachedImages()
        
    
        // Try listing the contents of the cache folder to confirm it’s empty.
        let filesAfterRemoval: [URL]
        do {
            filesAfterRemoval = try await FileManager.default.contentsOfDirectory(
                at: imageCache.imagesDirectory,
                includingPropertiesForKeys: nil,
                options: .skipsHiddenFiles
            )
        } catch {
            fatalError()
        }
        
        #expect(filesAfterRemoval.isEmpty, "Expected the cache folder to be empty after removal.")
    }
}
