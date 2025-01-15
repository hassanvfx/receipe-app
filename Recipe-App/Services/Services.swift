//
//  Services.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

enum Services {}

/// In real life this could be optimized with a dependency injection service
/// Services here are expected to be accesed to multiple threads
/// And should implement their own thread-safe logic
extension Services {
    nonisolated(unsafe) static let api = APIService()
    nonisolated(unsafe) static let log = LoggingService()
    static let images = ImageCache()
}
