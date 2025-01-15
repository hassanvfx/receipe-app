//
//  Style.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//
import UIKit
import SwiftUI

enum Style {
    static let padding: CGFloat = 16
    static let thumbSize: CGSize = CGSize(width: 60, height: 60)
    static let displaySize: CGSize = CGSize(width: 120, height: 120)
    static let largeSize: CGSize = CGSize(width: 200, height: 200)
    
    static let cornerRadius: CGFloat = 8
}
extension Style {
    enum Colors {
        static let backgroundColor: Color = Color(uiColor: .systemBackground)
        static let textColor: Color =  Color(uiColor: .label)
        static let inactive: Color =  Color.gray.opacity(0.3)
        static let active: Color =  Color.blue.opacity(0.3)
    }
}

