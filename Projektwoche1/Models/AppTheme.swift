
//
//  AppTheme.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 04.03.26.
//


import SwiftUI

struct AppTheme {
    let textColor: Color
    let tintColor: Color
}

extension AppTheme {
    // Neutral/default themes
    static let normal = AppTheme(
        textColor: .primary,
        tintColor: .blue
    )

    static let cyan = AppTheme(
        textColor: .primary,
        tintColor: .cyan
    )

    static let light = AppTheme(
        textColor: .primary,
        tintColor: .blue
    )
    
    static let blue = AppTheme(
        textColor: .primary,
        tintColor: .blue
    )
    
    static let mint = AppTheme(
        textColor: .primary,
        tintColor: .mint
    )

    // Additional color themes
    static let green = AppTheme(
        textColor: .primary,
        tintColor: .green
    )

    static let teal = AppTheme(
        textColor: .primary,
        tintColor: .teal
    )

    static let indigo = AppTheme(
        textColor: .primary,
        tintColor: .indigo
    )

    static let purple = AppTheme(
        textColor: .primary,
        tintColor: .purple
    )

    static let pink = AppTheme(
        textColor: .primary,
        tintColor: .pink
    )

    static let orange = AppTheme(
        textColor: .primary,
        tintColor: .orange
    )

    static let red = AppTheme(
        textColor: .primary,
        tintColor: .red
    )
}
