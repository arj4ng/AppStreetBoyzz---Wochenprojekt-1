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
    
    static let cyan = AppTheme(
        textColor: .cyan,
        tintColor: .cyan
    )
    static let light = AppTheme(
        textColor: .gray,
        tintColor: .gray
    )
    
    static let blue = AppTheme(
        textColor: .blue,
        tintColor: .blue
    )
    
    static let mint = AppTheme(
        textColor: .mint,
        tintColor: .mint
    )

}
