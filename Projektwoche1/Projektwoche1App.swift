//
//  Projektwoche1App.swift
//  Projektwoche1
//
//  Created by Jana Jansen on 24.01.25.
//

import SwiftUI

import SwiftUI
import SwiftData

@main
struct Projektwoche1App: App {
    @StateObject private var themeManager = ThemeManager()
    @AppStorage("darkmode") private var darkMode = false
    @State private var showSplash = true
  var body: some Scene {
    WindowGroup {
        ZStack {
            Color.black.ignoresSafeArea()

            CashFlowTabView()
                .environmentObject(themeManager)
                .preferredColorScheme(darkMode ? .dark : .light)
                .opacity(showSplash ? 0 : 1)
                .animation(.easeInOut(duration: 0.35), value: showSplash)

            if showSplash {
                SplashScreenView {
                    withAnimation(.easeOut(duration: 0.2)) {
                        showSplash = false
                    }
                }
                .zIndex(1)
            }
        }
    }
    .modelContainer(for: [Budget.self, Expense.self, Recipt.self, MonthlyCost.self])
  }
}
