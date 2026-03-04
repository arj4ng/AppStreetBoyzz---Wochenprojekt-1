<h1 align="center">💸 CashFlow App (SwiftUI + SwiftData)</h1>

<p align="center">
  <strong>Bootcamp Team Project</strong><br>
  <sub>Wochenprojekt · Aktueller Stand</sub>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5-orange?logo=swift" alt="Swift 5" />
  <img src="https://img.shields.io/badge/Framework-SwiftUI-0A84FF" alt="SwiftUI" />
  <img src="https://img.shields.io/badge/Data-SwiftData-34C759" alt="SwiftData" />
  <img src="https://img.shields.io/badge/Platform-iOS-lightgrey?logo=apple" alt="iOS" />
  <img src="https://img.shields.io/badge/Status-In%20Progress-f59e0b" alt="In Progress" />
</p>

## About
CashFlow hilft dabei, Budgets pro Kategorie im Blick zu behalten.
Budgets und zugehörige Ausgaben werden in SwiftData gespeichert.
Die App zeigt Summen, Restbudget und Budgetverbrauch visuell an.

## Team
<table>
  <tr>
    <td align="center">
      <img src="Projektwoche1/ReadMe%20Assets/arjang.jpeg" width="90" alt="arj4ng" /><br/>
      <a href="https://github.com/arj4ng"><strong>@arj4ng</strong></a>
    </td>
    <td align="center">
      <img src="Projektwoche1/ReadMe%20Assets/Alisan.png" width="90" alt="AlisanAys" /><br/>
      <a href="https://github.com/AlisanAys"><strong>@AlisanAys</strong></a>
    </td>
    <td align="center">
      <img src="Projektwoche1/ReadMe%20Assets/Hendrik.png" width="90" alt="hendrikp90" /><br/>
      <a href="https://github.com/hendrikp90"><strong>@hendrikp90</strong></a>
    </td>
    <td align="center">
      <img src="Projektwoche1/ReadMe%20Assets/Nils.jpeg" width="90" alt="Nils-ui" /><br/>
      <a href="https://github.com/Nils-ui"><strong>@Nils-ui</strong></a>
    </td>
  </tr>
</table>

## Implemented Features
- SwiftData Modelle `Budget` und `Expense` mit Relationship (`deleteRule: .cascade` auf Budget-Expenses)
- Budget-Übersicht mit `@Query` und Navigation zur Detailansicht
- Neues Budget per Sheet (`AddBudgetView`)
- Budget löschen per Swipe in der Übersicht
- Gesamtwerte in der Übersicht:
  - Gesamtbudget
  - Gesamtausgaben
  - Verfügbar
- Visuelle Übersicht mit kreisförmigen Progress-Indikatoren
- Budgetkarten mit verbleibendem Betrag + linearem Budgetverbrauch
- Budget-Detailansicht mit:
  - Geplant / Ausgegeben / Verfügbar
  - Liste aller Ausgaben eines Budgets
  - Toggle „bezahlt / nicht bezahlt" pro Ausgabe
- Neue Ausgabe per Sheet (`ExpenseAddView`)
- Einzelne Ausgabe löschen per Swipe
- Tab-Navigation: Home, Analyse, Einstellungen
- Theme- und UI-Einstellungen:
  - Dark Mode Toggle
  - Schriftgröße
  - Theme Picker (mehrere Farbschemata)

## Current Project Structure
```text
Projektwoche1/
├── Models/
│   ├── AppTheme.swift
│   ├── ThemeManager.swift
│   ├── Budget.swift
│   └── Expense.swift
├── Views/
│   ├── CashFlowTabView.swift
│   └── SubViews/
│       ├── BudgetListView.swift
│       ├── BudgetDetailView.swift
│       ├── AddBudgetView.swift
│       ├── ExpenseAddView.swift
│       ├── ProgressView.swift
│       ├── SettingsView.swift
│       └── AnalyseView.swift
├── ContentView.swift
└── Projektwoche1App.swift
```

## How To Run
1. `Projektwoche1.xcodeproj` in Xcode öffnen.
2. Scheme `Projektwoche1` auswählen.
3. iOS Simulator wählen.
4. Mit `⌘ + R` starten.
