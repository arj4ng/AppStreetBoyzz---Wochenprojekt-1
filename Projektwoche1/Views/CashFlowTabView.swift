//
//  CashFlowTabView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 04.03.26.
//

import SwiftUI
import SwiftData

struct CashFlowTabView: View {
    @State private var selection = 0
    @AppStorage("fontsize") private var fontSize = 14.0
    @AppStorage("darkmode") private var darkMode = false
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house", value: 0) {
                BudgetListView()
            }
            
            Tab("Analyse", systemImage: "eurosign.gauge.chart.leftthird.topthird.rightthird", value: 1) {
                AnalyseView()
            }
            Tab("Einstellungen", systemImage: "gear", value: 2) {
                SettingsView()
                    .tint(themeManager.currentTheme.tintColor)
            }
            
        }
        .font(.system(size: fontSize))
        .foregroundStyle(themeManager.currentTheme.textColor)
        .tint(themeManager.currentTheme.tintColor)
        .preferredColorScheme(darkMode ? .dark : .light)
    }
    
}


#Preview {
    CashFlowTabView()
        .environmentObject(ThemeManager()) 
        .modelContainer(for: [Budget.self, Expense.self])
}
