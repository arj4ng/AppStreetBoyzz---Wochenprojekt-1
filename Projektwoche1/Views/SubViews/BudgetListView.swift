//
//  BudgetListView.swift
//  Projektwoche1
//
//  Created by Nils Adomeit on 02.03.26.
//

import SwiftUI
import SwiftData

struct BudgetListView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var budgets: [Budget]
    
    @State private var showSheet: Bool = false
    @State private var showDetails: Bool = false
    
    var totalBudget: Double {
        budgets.reduce(0) { $0 + $1.plannedAmount }
    }

    var totalExpenses: Double {
        budgets.reduce(0) { $0 + $1.totalSpent }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                Text("Gesamtbudget: \(totalBudget, format: .currency(code: "EUR"))")
                    .font(.title2)
                    .bold()
                Text("Gesamtausgaben: \(totalExpenses, format: .currency(code: "EUR"))")
                    .opacity(0.5)
            }
            .font(.headline)
            .padding()
                
            List {
                ForEach(budgets) { budget in
                    Section{
                        VStack(){
                            HStack{
                                Text(budget.name)
                                    .bold()
                                Spacer()
                                Text("\(Int(budget.plannedAmount)) Euro")
                                    .bold()
                            }
                            HStack{
                                Text("Verbleibend:")
                                Spacer()
                                Text("\(Int(budget.remainingAmount)) Euro")
                                    .foregroundStyle(
                                        budget.remainingAmount < budget.plannedAmount * 0.1 ? .red : .green
                                    )
                            }
                            ProgressView(budget: budget)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    context.delete(budget)
                                }
                            }
                            NavigationLink("Details anzeigen"){
                                BudgetDetailView(budget: budget)
                            }.foregroundStyle(.blue)
                            
                        }
                       
                    }
                }
.padding(20)
.background(Color.white.opacity(0.5))
.cornerRadius(30)
.shadow(color: .black.opacity(0.6), radius: 20, x: 0, y:8)
                
            }
            
            .navigationTitle("Budgets")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddBudgetView()
                    .presentationDetents([.height(400), .large])
            }
        }
    }
    
}

#Preview {
    BudgetListView()
        .modelContainer(for: [Budget.self], inMemory: true)
}
