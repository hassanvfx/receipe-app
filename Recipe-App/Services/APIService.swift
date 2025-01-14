//
//  APIService.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import Foundation

/// This service is designed to contain the network abstraction
class APIService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
}

/// Extension that defines known states and errors
extension APIService {
    enum APIError: Error {
        case decoding(DecodingError)
        case server(Error)
        case unknown
    }
}

/// The actual calling function
extension APIService {

    func fetchRecipes(from urlString: String) async throws -> APIRecipes {
            guard let url = URL(string: urlString) else {
                throw APIError.unknown
            }
            do {
                let (data, _) = try await session.data(from: url)
                let decodedResponse = try JSONDecoder().decode(APIRecipes.self, from: data)
                let recipes = decodedResponse.recipes
                
                /// This is the expected Happy Path
                return APIRecipes(recipes: recipes)
                
            } catch let decodingError as DecodingError {
                // Malformed data
                throw APIError.decoding(decodingError)
            } catch {
                // Network or other
                throw APIError.server(error)
            }
        }
}
