//
//  APIEndpointProtocol.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import Foundation
import UIKit

protocol APIEndpointProtocol {
    var path: String { get }
    var mockValid: Data { get }
    var mockEmpty: Data { get }
    var mockInvalid: Data { get }
}
