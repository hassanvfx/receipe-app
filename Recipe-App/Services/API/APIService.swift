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
        try await APIService.get(session: session, from: APIService.Endpoint.recipes.path)
    }
}

/// The actual calling function
/// The low level calling happens in a static function aka the api engine to encourage isolation and inform the intent of not handling ANY kind of mutable state
///
extension APIService {
    static func get<T: Decodable & Sendable>(
            session: URLSession,
            from urlString: String
        ) async throws -> T {
            guard let url = URL(string: urlString) else {
                throw Failure.unknown
            }
            
            do {
                let (data, _) = try await session.data(from: url)
                
                // Decoding off the main thread
                let decodedResponse = try await Task.detached(priority: nil) {
                    return try JSONDecoder().decode(T.self, from: data)
                }.value
                
                return decodedResponse
            } catch let decodingError as DecodingError {
                throw Failure.decoding(decodingError)
            } catch {
                throw Failure.server(error)
            }
        }
}
