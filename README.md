<h1 align="center">💸 CashFlow App (SwiftUI + SwiftData)</h1>

<p align="center">
  <strong>Bootcamp Team Project</strong><br>
  <sub>Wochenprojekt · Final Version</sub>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5-orange?logo=swift" alt="Swift 5" />
  <img src="https://img.shields.io/badge/Framework-SwiftUI-0A84FF" alt="SwiftUI" />
  <img src="https://img.shields.io/badge/Data-SwiftData-34C759" alt="SwiftData" />
  <img src="https://img.shields.io/badge/Platform-iOS-lightgrey?logo=apple" alt="iOS" />
  <img src="https://img.shields.io/badge/Status-Finished-22c55e" alt="Finished" />
</p>

## About
CashFlow ist eine iOS App zum Verwalten von persönlichen Finanzen mit Fokus auf:
- Budgets
- Ausgaben
- Fixkosten
- Quittungen (mit Bildimport)

Die App nutzt SwiftData für Persistenz und bietet ein tab-basiertes UI mit Splash-Screen, Theme-Einstellungen und editierbaren Datenflows.

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
- Splash Screen mit Video-Intro und weichem Übergang zur App
- Tab Navigation:
  - Home (Budgets)
  - Fixkosten
  - Quittungen
  - Einstellungen
- Budget Management:
  - Budget erstellen
  - Budget löschen (mit Bestätigung)
  - Budget-Detailansicht mit editierbaren Feldern
  - Summenberechnung (geplant, ausgegeben, verfügbar)
  - Fortschrittsanzeigen (Gauge + Progress)
- Expense Management:
  - Ausgabe hinzufügen
  - Ausgabe löschen
  - Ausgabe als bezahlt markieren (`isPaid`)
  - Inline-Bearbeitung im Budget-Detail
- Monthly Costs:
  - Fixkosten hinzufügen und löschen
  - Gesamtsumme der Fixkosten
- Receipt Management:
  - Beleg hinzufügen (`ReciptAddView`)
  - Bildquelle: Kamera, Mediathek, Dateiimport
  - Beleg bearbeiten (`ReciptEditView`)
  - Beleg löschen (`ReciptListView`)
- Settings & Theme:
  - Dark Mode
  - Schriftgröße
  - Theme Picker mit mehreren Farbschemata
- Logging:
  - Eigene App-Logs mit Zeitstempeln (`AppLog`)

## Data Models
- `Budget`
- `Expense`
- `MonthlyCost`
- `Recipt`
- `AppTheme` + `ThemeManager`

## Current Project Structure
```text
Projektwoche1/
├── Models/
│   ├── AppLog.swift
│   ├── AppTheme.swift
│   ├── ThemeManager.swift
│   ├── Budget.swift
│   ├── Expense.swift
│   ├── MonthlyCost.swift
│   └── Recipt.swift
├── Views/
│   ├── CashFlowTabView.swift
│   ├── SplashScreenView.swift
│   └── SubViews/
│       ├── BudgetListView.swift
│       ├── BudgetDetailView.swift
│       ├── AddBudgetView.swift
│       ├── ExpenseAddView.swift
│       ├── ProgressView.swift
│       ├── MontlyCostView.swift
│       ├── MontlyAddView.swift
│       ├── ReciptListView.swift
│       ├── ReciptAddView.swift
│       ├── ReciptEditView.swift
│       └── SettingsView.swift
├── Assets.xcassets/
├── Splash Screen/
└── Projektwoche1App.swift
```

## How To Run
1. `Projektwoche1.xcodeproj` in Xcode öffnen.
2. Scheme `Projektwoche1` auswählen.
3. iOS Simulator oder physisches Gerät wählen.
4. Mit `⌘ + R` starten.
