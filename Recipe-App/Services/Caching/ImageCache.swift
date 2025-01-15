//
//  CacheService.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

import SwiftUI
import CryptoKit

actor ImageCache {
    
    private let cacheDirectory: URL = {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }()
    
    /// Computes the MD5 hash of the given string and returns it as a lowercase hex string.
    private func md5Hash(of string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func fetch(from url: URL) async -> UIImage? {
        
        let hash = md5Hash(of: url.absoluteString)
        
        let fileExtension = url.pathExtension
        let hashedFilename = fileExtension.isEmpty ? hash : "\(hash).\(fileExtension)"
        
        let fileURL = cacheDirectory.appendingPathComponent(hashedFilename)
        
        Services.log.info("Fetching image from \(url.absoluteString)")
        
        // Check if file exists on disk
        if FileManager.default.fileExists(atPath: fileURL.path),
           let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            Services.log.info("Image found on disk \(fileURL.path)")
            return image
        }
        
        // Otherwise, download it
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            
            // Cache to disk in a background detached task
            Task.detached(priority: .background) {
                do {
                    try data.write(to: fileURL)
                    Services.log.info("Image successfully written to disk at \(fileURL.path)")
                } catch {
                    Services.log.error("Failed to write image to disk: \(error.localizedDescription)")
                }
            }
            
            // return immediately
            return image
            
        } catch {
            
            Services.log.error("Failed to create UIImage from server data")
            
            return nil
        }
    }
}
