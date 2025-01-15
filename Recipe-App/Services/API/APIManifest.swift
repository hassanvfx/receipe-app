//
//  APIManifest.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

import Foundation

/// Extension that defines known endpoints and errors
extension APIService {
    enum Endpoint {
        case recipes
    }
    
    enum Failure: Error {
        case decoding(DecodingError)
        case server(Error)
        case unknown
    }
}

/// Implementing the API Endpoint Protocol
extension APIService.Endpoint: APIEndpointProtocol {
    var mockValid: Data {
        Mocking.recipesValid
    }
    
    var mockEmpty: Data {
        Mocking.recipesEmpty
    }
    
    var mockInvalid: Data {
        Mocking.recipedMalformed
    }
    
    public var path: String {
        switch self {
        case .recipes:
            return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        }
    }
    
}
