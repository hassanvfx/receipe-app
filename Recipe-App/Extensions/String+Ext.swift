//
//  String+Ext.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

import Foundation

extension String {
    /// Converts the string to `Data` using UTF-8 encoding.
    /// - Returns: A `Data` object if the conversion is successful, otherwise `nil`.
    var utf8Data: Data? {
        Data(self.utf8)
    }
}
