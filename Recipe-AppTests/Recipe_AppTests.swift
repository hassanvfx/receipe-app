//
//  Recipe_AppTests.swift
//  Recipe-AppTests
//
//  Created by Hassan on 14/01/25.
//

import Testing
@testable import Recipe_App
struct Recipe_AppTests {
    
    @Test
    func testFetchRecipes_withMockSuccess_shouldReturnRecipes() async throws {
        
        let apiService = APIService(session: .shared, mocking: .success)
        let response = try await apiService.fetchRecipes()
        
        #expect(!response.recipes.isEmpty, "Expected a non-empty list of recipes.")
        #expect(response.recipes.count == 6, "Expected 6 recipes in the valid JSON.")
        #expect(response.recipes.first?.name == "Apam Balik",
                "First recipe name should match the mock JSON.")
    }
    
    @Test
    func testFetchRecipes_withMockMalformedItems_shouldReturnSome() async throws {
        
        let apiService = APIService(session: .shared, mocking: .failure)
        let response = try await apiService.fetchRecipes()
        let validRecipes = response.recipes.map{ Recipe(apiRecipe: $0)}.compactMap{$0}
       
        #expect(!response.recipes.isEmpty, "Expected a non-empty list of recipes.")
        #expect(response.recipes.count == 63, "Expected 63 recipes in the valid JSON.")
        #expect(validRecipes.count == 60, "Expected 60 recipes in the valid JSON.")
      
    }
    
    @Test
    func testFetchRecipes_withMockEmpty() async throws {
        
        let apiService = APIService(session: .shared, mocking: .empty)
        let response = try await apiService.fetchRecipes()
        
        #expect(response.recipes.isEmpty, "Expected a empty list of recipes.")
        #expect(response.recipes.count == 0, "Expected 0 recipes in the valid JSON.")
    }
    
}
