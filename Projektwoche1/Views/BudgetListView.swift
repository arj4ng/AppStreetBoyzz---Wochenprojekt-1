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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(budgets) { budget in
                    Text(budget.name)
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
}
