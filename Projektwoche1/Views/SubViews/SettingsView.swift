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
    var body: some View {
        List{
            Toggle("Dunkler Modus", isOn: $darkMode)
                .preferredColorScheme(darkMode ? .dark : .light)
            Slider(value: $fontSize,in: 14...22)
            Text("Aktuelle Schriftgröße: \(Int(fontSize))")
        }
    }
}

#Preview {
    SettingsView()
}
