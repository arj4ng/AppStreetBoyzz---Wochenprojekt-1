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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(budgets) { budget in
                    Section{
                        VStack(spacing: 8){
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
                            }
                            
                        }
                       
                    }
                }

                
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
