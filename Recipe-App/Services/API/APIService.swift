//
//  APIService.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import Foundation

/// This service is designed to contain the network abstraction
/// The class provides a reference to a shared URL session by default
/// The methods are intented to be expressive shorthands for high level operations

///
class APIService {
    static let session = URLSession.shared
    
    private let session: URLSession
    init(session: URLSession = APIService.session) {
        self.session = session
    }
}

extension APIService {
    func fetchRecipes() async throws -> APIRecipes {
        try await APIService.getRecipes(session: session, from: APIService.Endpoint.recipes.path)
    }
}

/// The actual calling function
/// The low level calling happens in a static function aka the api engine to encourage isolation and inform the intent of not handling ANY kind of mutable state
///
extension APIService {
    static func getRecipes(session: URLSession, from urlString: String) async throws -> APIRecipes {
            guard let url = URL(string: urlString) else {
                throw Failure.unknown
            }
            do {
                
                // Make the network call (URLSession runs in the background already)
                let (data, _) = try await session.data(from: url)
                
                // Decoding in a background thread
                let decodedResponse = try await Task.detached(priority: nil) {
                       return try JSONDecoder().decode(APIRecipes.self, from: data)
                   }.value
                
                
                // This is the expected Happy Path
                return APIRecipes(recipes: decodedResponse.recipes)
                
            } catch let decodingError as DecodingError {
                
                // Malformed data
                throw Failure.decoding(decodingError)
            } catch {
                
                // Network or other
                throw Failure.server(error)
            }
        }
}
