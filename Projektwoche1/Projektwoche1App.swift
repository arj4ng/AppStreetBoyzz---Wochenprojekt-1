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
  var body: some Scene {
    WindowGroup {
      CashFlowTabView()
            .environmentObject(themeManager)
            .preferredColorScheme(darkMode ? .dark : .light) //
    }
    .modelContainer(for: [Budget.self, Expense.self])
  }
}
