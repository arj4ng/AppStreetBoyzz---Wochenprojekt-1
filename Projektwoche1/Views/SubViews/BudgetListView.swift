//
//  BudgetListView.swift
//  Projektwoche1
//
//  Created by Nils Adomeit on 02.03.26.
//

import SwiftUI
import SwiftData

//
// BudgetListView.swift
// Projektwoche1
//
// Created by Nils Adomeit on 02.03.26.
//
import SwiftUI
import SwiftData
struct BudgetListView: View {
  
  @Environment(\.modelContext) private var context
  @Query private var budgets: [Budget]
  @State private var budgetToDelete: Budget?
  @State private var showSheet: Bool = false
  
  var totalBudget: Double {
    budgets.reduce(0) { $0 + $1.plannedAmount }
  }
  var totalExpenses: Double {
    budgets.reduce(0) { $0 + $1.totalSpent }
  }
  
  var totalRemaining: Double {
    totalBudget - totalExpenses
  }
  
  var overallUsage: Double {
    guard totalBudget > 0 else { return 0 }
    return min(max(totalExpenses / totalBudget, 0), 1)
  }
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          VStack(alignment: .center) {
              Text("Übersicht")
                .font(.largeTitle)
                .fontWeight(.semibold)
              Spacer()
                .font(.caption)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 12) {
              CircularMetricView(
                title: "Budget",
                value: totalBudget.formatted(.currency(code: "EUR")),
                progress: 1,
                tint: .blue
              )
              
              CircularMetricView(
                title: "Ausgaben",
                value: totalExpenses.formatted(.currency(code: "EUR")),
                progress: overallUsage,
                tint: overallUsage >= 0.9 ? .red : .orange
              )
              
              CircularMetricView(
                title: "Verfügbar",
                value: totalRemaining.formatted(.currency(code: "EUR")),
                progress: max(1 - overallUsage, 0),
                tint: totalRemaining < 0 ? .red : .green
              )
            }
          }
          .padding(.vertical, 8)
        }
        
        Section("Deine Budgets") {
          ForEach(budgets) { budget in
            NavigationLink {
              BudgetDetailView(budget: budget)
            } label: {
              VStack(alignment: .leading, spacing: 10) {
                HStack {
                  Text(budget.name)
                    .font(.headline)
                  Spacer()
                  Text(budget.plannedAmount, format: .currency(code: "EUR"))
                    .font(.subheadline)
                    .bold()
                }
                
                HStack {
                  Text("Verbleibend")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                  Spacer()
                  Text(budget.remainingAmount, format: .currency(code: "EUR"))
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(
                      budget.remainingAmount < budget.plannedAmount * 0.1 ? .red : .green
                    )
                }
                
                ProgressView(budget: budget)
              }
            }
            .swipeActions(edge: .trailing) {
              Button(role: .destructive) {
//                context.delete(budget)
                  budgetToDelete = budget
              } label: {
                Label("Löschen", systemImage: "trash")
              }
            }
          } 
        }
      }
      .listStyle(.insetGrouped)
      .contentMargins(.top, 10, for: .scrollContent)
      .navigationTitle("CashFlow")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            showSheet = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
      .tint(nil)
      .sheet(isPresented: $showSheet) {
        AddBudgetView()
          .presentationDetents([.height(400), .large])
      }
      .alert(
            "Budget wirklich löschen?",
            isPresented: Binding(
             get: { budgetToDelete != nil },
             set: { if !$0 { budgetToDelete = nil } }
            ),
            presenting: budgetToDelete
           ) { budget in
            Button("Abbrechen", role: .cancel) {
             budgetToDelete = nil
            }
            Button("Löschen", role: .destructive) {
             context.delete(budget)
             budgetToDelete = nil
            }
           } message: { budget in
            Text("Möchtest du das Budget „\(budget.name)“ wirklich löschen?")
           }
    }
      
  }
    
        
}

private struct CircularMetricView: View {
  let title: String
  let value: String
  let progress: Double
  let tint: Color
  
  var body: some View {
    VStack {
      Gauge(value: min(max(progress, 0), 1), in: 0...1) {
      } currentValueLabel: {
        Text("\(Int(min(max(progress, 0), 1) * 100))%")
          .font(.headline)
          .fontWeight(.semibold)
      }
      .gaugeStyle(.accessoryCircularCapacity)
      .tint(tint)
      .frame(width: 100, height: 90)
      .scaleEffect(1.3)
        
      Text(title)
        .font(.caption)
        .foregroundStyle(.secondary)
      
      Text(value)
        .font(.subheadline)
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
    .frame(maxWidth: .infinity)
  }
}
#Preview {
    BudgetListView()
        .modelContainer(for: [Budget.self], inMemory: true)
}
