//
//  BudgetDetailView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 03.03.26.
//

import SwiftUI

struct BudgetDetailView: View {
    
    var budget: Budget
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Text("Geplant: \(budget.plannedAmount) Euro")
        Text("Ausgegeben: \(budget.totalSpent) Euro")
        Text("Verfügbar: \(budget.remainingAmount) Euro")
            .foregroundStyle(budget.remainingAmount < 100 ? .red : .green)
    }
}

