//
//  SettingsView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 04.03.26.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    @AppStorage("darkmode") private var darkMode = false
    @AppStorage("fontsize") private var fontSize = 14.0
    @AppStorage("selectedTheme") private var selectedTheme = "light"
    @State private var audioPlayer: AVAudioPlayer?
    @EnvironmentObject var themeManager: ThemeManager
    
    private let themeOptions: [(id: String, title: String, color: Color)] = [
        ("normal", "Standard", .blue),
        ("blue", "Blau", .blue),
        ("cyan", "Cyan", .cyan),
        ("mint", "Minze", .mint),
        ("green", "Grün", .green),
        ("teal", "Türkis", .teal),
        ("indigo", "Indigo", .indigo),
        ("purple", "Lila", .purple),
        ("pink", "Pink", .pink),
        ("orange", "Orange", .orange),
        ("red", "Rot", .red)
    ]
    
    var body: some View {
        NavigationStack{
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
                    Button("Sound abspielen") {
                        playSound()
                    }
                }
            }
            .onChange(of: selectedTheme) { _, newTheme in
                themeManager.setTheme(newTheme)
            }
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
            .tint(themeManager.currentTheme.tintColor)
            .onAppear {
                           setupAudio()
                       }
                   }
               }
               
               // MARK: - Audio Setup
               func setupAudio() {
                   guard let soundURL = Bundle.main.url(forResource: "meinSound", withExtension: "mp3") else {
                       print("Sound-Datei nicht gefunden!")
                       return
                   }
                   do {
                       audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                       audioPlayer?.prepareToPlay()
                   } catch {
                       print("Fehler beim Laden des Sounds: \(error.localizedDescription)")
                   }
               }
               
               // MARK: - Play Sound
               func playSound() {
                   audioPlayer?.currentTime = 0
                   audioPlayer?.play()
               }
           }

#Preview {
SettingsView()
.environmentObject(ThemeManager())
.modelContainer(for: [Budget.self, Expense.self])
}

