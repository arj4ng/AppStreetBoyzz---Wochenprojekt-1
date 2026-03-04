//
//  ThemeManager.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 04.03.26.
//
import Foundation
import SwiftData
import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("selectedTheme") private var selectedTheme: String = "light"

    @Published var currentTheme: AppTheme = .light

    init() {
        loadTheme()
    }

    func setTheme(_ theme: String) {
        selectedTheme = theme
        loadTheme()
    }

    private func loadTheme() {
        switch selectedTheme {
        case "normal":
            currentTheme = .normal
        case "blue":
            currentTheme = .blue
        case "cyan":
            currentTheme = .cyan
        case "mint":
            currentTheme = .mint
        case "green":
            currentTheme = .green
        case "teal":
            currentTheme = .teal
        case "indigo":
            currentTheme = .indigo
        case "purple":
            currentTheme = .purple
        case "pink":
            currentTheme = .pink
        case "orange":
            currentTheme = .orange
        case "red":
            currentTheme = .red
        default:
            currentTheme = .light
        }
    }
}
