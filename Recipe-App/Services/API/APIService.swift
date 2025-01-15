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
        try await APIService.get(session: session,
                                 mocking: mocking,
                                 endpoint: APIService.Endpoint.recipes)
    }
}

/// The actual calling function
/// The low level calling happens in a static function aka the api engine to encourage isolation and inform the intent of not handling ANY kind of mutable state
///
extension APIService {
    static func get<T: Decodable & Sendable>(
        session: URLSession,
        mocking: Mock,
        endpoint: APIEndpointProtocol
    ) async throws -> T {
        guard let url = URL(string: endpoint.path) else {
            throw Failure.unknown
        }
        
        switch mocking {
        case .none: break
            
        case .success:
            return try await APIService.decodeJSON(from: endpoint.mockValid)
            
        case .empty:
            return try await APIService.decodeJSON(from: endpoint.mockEmpty)
            
        case .failure:
            return try await APIService.decodeJSON(from: endpoint.mockInvalid)
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
