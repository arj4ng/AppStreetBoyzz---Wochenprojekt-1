//
//  SettingsView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 04.03.26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("darkmode") private var darkMode = false
    @AppStorage("fontsize") private var fontSize = 14.0
    @AppStorage("selectedTheme") private var selectedTheme = "light"

    @EnvironmentObject var themeManager: ThemeManager

    private let themeOptions: [(id: String, title: String, color: Color)] = [
        ("normal", "Standard", .blue),
        ("light", "Light", .blue),
        ("blue", "Blue", .blue),
        ("cyan", "Cyan", .cyan),
        ("mint", "Mint", .mint),
        ("green", "Green", .green),
        ("teal", "Teal", .teal),
        ("indigo", "Indigo", .indigo),
        ("purple", "Purple", .purple),
        ("pink", "Pink", .pink),
        ("orange", "Orange", .orange),
        ("red", "Red", .red)
    ]

    var body: some View {
        List {
            Section("Darstellung") {
                Toggle("Dunkler Modus", isOn: $darkMode)
                
                Picker("Theme", selection: $selectedTheme) {
                    ForEach(themeOptions, id: \.id) { option in
                        HStack(spacing: 10) {
                            Circle()
                                .fill(option.color)
                                .frame(width: 12, height: 12)
                            Text(option.title)
                        }
                        .tag(option.id)
                    }
                }
                .pickerStyle(.menu)

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Schriftgröße")
                        Spacer()
                        Text("\(Int(fontSize))")
                            .foregroundStyle(.secondary)
                    }
                    Slider(value: $fontSize, in: 14...22)
                }
            }
        }
        .onChange(of: selectedTheme) { _, newTheme in
            themeManager.setTheme(newTheme)
        }
        .navigationTitle("Einstellungen")
        .navigationBarTitleDisplayMode(.inline)
        .tint(themeManager.currentTheme.tintColor)
    }
}

#Preview {
SettingsView()
.environmentObject(ThemeManager())
.modelContainer(for: [Budget.self, Expense.self])
}

