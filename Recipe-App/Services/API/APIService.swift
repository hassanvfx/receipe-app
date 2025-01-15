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
actor APIService {
    private let session: URLSession
    private let mocking: Mock
    init(session: URLSession = URLSession.shared, mocking: Mock = .none) {
        self.session = session
        self.mocking = mocking
    }
}

extension APIService {
    func fetchRecipes() async throws -> APIRecipes {
        switch mocking {
            case .none:
            return try await APIService.get(session: session, from: APIService.Endpoint.recipes.path)
            
        case .success:
            return try await APIService.decodeJSON(from: Mocking.recipesValid)
            
        case .empty:
            return try await APIService.decodeJSON(from: Mocking.recipesEmpty)
            
        case .failure:
            return try await APIService.decodeJSON(from: Mocking.recipedMalformed)
        } 
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
            return try await decodeJSON(from: data)
        } catch let decodingError as DecodingError {
            throw Failure.decoding(decodingError)
        } catch {
            throw Failure.server(error)
        }
    }
}

extension APIService {
    
    
    /// Use a background Task for decoding
    static func decodeJSON<T: Decodable & Sendable>(from data: Data) async throws -> T {
        return try await Task.detached(priority: .background) {
            return try JSONDecoder().decode(T.self, from: data)
        }.value
    }
    
}
