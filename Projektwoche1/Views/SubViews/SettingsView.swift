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
    @EnvironmentObject var themeManager: ThemeManager
    @State private var notificationsSheet = false
    var body: some View {
        List{
           Toggle("Dunkler Modus", isOn: $darkMode)
            Button {
                notificationsSheet.toggle()
            } label: {
                Label("Schriftfarbe einstellen", systemImage: "pencil.tip.crop.circle")
            }
            Slider(value: $fontSize,in: 14...22)
            Text("Aktuelle Schriftgröße: \(Int(fontSize))")
        } .sheet(isPresented: $notificationsSheet) {
            Text("Schriftfarbe")
                .font(.title)
                .padding()
            if darkMode {
                List{

                    Button("Blaue Schrift") {
                        themeManager.setTheme("blue")
                    }
                    
                    Button("Cyanische Schrift") {
                        themeManager.setTheme("cyan")
                    }
                    Button("Minzige Schrift") {
                        themeManager.setTheme("mint")
                    }
                }
                .presentationDetents([.height(350)])
            } else {
                List{
                    Button("Graue Schrift") {
                        themeManager.setTheme("light")
                    }
                }
                .presentationDetents([.height(250)])
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
        .modelContainer(for: [Budget.self, Expense.self])
}
