<h1 align="center">💸 CashFlow App (SwiftUI + SwiftData)</h1>

<p align="center">
  <strong>Bootcamp Team Project</strong><br>
  <sub>Wochenprojekt · CashFlow MVP</sub>
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
Für jedes Budget können Ausgaben erfasst werden, sodass geplantes Budget, ausgegeben und verfügbar angezeigt werden.

## Team
<table>
  <tr>
    <td align="center">
      <img src="Projektwoche1/ReadMe%20Assets/arjang.jpeg" width="90" alt="arj4ng" /><br/>
      <a href="https://github.com/arj4ng"><strong>@arj4ng</strong></a>
    </td>
    <td align="center">
      <img src="Projektwoche1/ReadMe%20Assets/Alisan1.png" width="90" alt="AlisanAys" /><br/>
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

## MVP Features
- Budget Übersicht mit Liste aller Budgets
- Neues Budget per Sheet anlegen
- Navigation zur Budget Detailansicht
- Ausgaben pro Budget anzeigen
- Neue Ausgabe hinzufügen
- Budgets & Ausgaben in SwiftData speichern
- Budgets und einzelne Ausgaben löschen
- Summen anzeigen: geplant / ausgegeben / verfügbar

## Current Project Structure
```text
Projektwoche1/
├── Models/
│   ├── Budget.swift
│   └── Expense.swift
├── Views/
│   ├── BudgetListView.swift
│   └── AddBudgetView.swift
├── ContentView.swift
└── Projektwoche1App.swift
```

## How To Run
1. `Projektwoche1.xcodeproj` in Xcode öffnen.
2. Scheme `Projektwoche1` auswählen.
3. iOS Simulator wählen.
4. Mit `⌘ + R` starten.

## Roadmap (Short)
- BudgetDetailView fertigstellen
- AddExpenseView integrieren
- Delete Flows für Budget & Expense abschließen
- Summen & optional ProgressView finalisieren
- MVP Smoke Test durchführen
