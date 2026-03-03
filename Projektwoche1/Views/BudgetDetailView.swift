//
//  BudgetDetailView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 03.03.26.
//

import SwiftData
import SwiftUI

struct BudgetDetailView: View {
    @State var addExpense: Bool = false
    var budget: Budget
    @Environment(\.modelContext) private var context

    var body: some View {

        VStack(spacing: 20) {

            VStack(alignment: .leading ,spacing: 10) {
                HStack {
                    Image(systemName: "sparkles.2")
                    Text("Budget:")
                        .font(.title2)
                        .bold()
                    Text(" \(budget.plannedAmount.formatted()) €")
                }
                HStack {
                    Image(systemName: "minus")
                    Text("Ausgegeben:")
                        .bold()
                    Text(" \(budget.totalSpent.formatted()) €")
                }
                HStack {
                    Image(systemName: "sun.max")
                    Text("Verfügbar:")
                        .bold()
                    Text(" \(budget.remainingAmount.formatted()) €")
                        .foregroundStyle(
                            budget.remainingAmount < budget.plannedAmount * 0.1 ? .red : .green
                        )
                }
                    .bold()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Button("Ausgabe hinzufügen") {
                addExpense.toggle()
            }
            .padding(10)
            .background(Color.blue)
            .cornerRadius(30)
            .padding(10)
            .foregroundStyle(.white)
            
            List {

                Section("Ausgaben") {
                  
                    if budget.expenses.isEmpty {
                        Text("Keine Ausgaben vorhanden")
                            .foregroundStyle(.secondary)
                    } else {

                        ForEach(budget.expenses) { expense in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(expense.title)
                                        .font(.headline)

//                                    Text(
//                                        expense.date,
//                                        format: .dateTime.day().month().year()
//                                    )
//                                    .font(.caption)
//                                    .foregroundStyle(.secondary)
                                }
                                Spacer()

                                Text(
                                    expense.amount,
                                    format: .currency(code: "EUR")
                                )
                            }
                        }
                        .onDelete(perform: deleteExpense)
                    }
                }
            }

        }
        .sheet(isPresented: $addExpense) {
            ExpenseAddView(budget: budget)
                .presentationDetents([.height(400), .large])
        }
        .navigationTitle(budget.name)
    }

    private func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = budget.expenses[index]
            context.delete(expense)
        }
        try? context.save()
    }

}

#Preview {
    let budget = Budget(name: "test", plannedAmount: 1000.00)

    return BudgetDetailView(budget: budget)
        .modelContainer(for: Budget.self)
}
