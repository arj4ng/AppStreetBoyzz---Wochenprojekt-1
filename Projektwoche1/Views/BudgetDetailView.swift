//
//  BudgetDetailView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 03.03.26.
//

import SwiftUI
import SwiftData

struct BudgetDetailView: View {
    
    var budget: Budget
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            VStack(spacing: 8) {
                
                Text("Geplant: \(budget.plannedAmount) Euro")
                    .font(.title2)
                Text("Ausgegeben: \(budget.totalSpent) Euro")
                
                Text("Verfügbar: \(budget.remainingAmount) Euro")
                    .foregroundStyle(budget.remainingAmount < 100 ? .red : .green)
                    .bold()
                
                    
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            
            List {
                
                Section("Ausgaben") {
                    
                    if budget.expenses.isEmpty {
                        Text("Keine Ausgaben vorhanden")
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    let budget = Budget(name: "test", plannedAmount: 1000.00)
    
    return BudgetDetailView(budget: budget)
        .modelContainer(for: Budget.self)
}
