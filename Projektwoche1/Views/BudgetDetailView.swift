//
//  BudgetDetailView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 03.03.26.
//

import SwiftData
import SwiftUI

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
                    .foregroundStyle(
                        budget.remainingAmount < 100 ? .red : .green
                    )
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
        .navigationTitle(budget.name)
    }

    private func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = budget.expenses[index]
            context.delete(expense)
        }
    }

}

#Preview {
    let budget = Budget(name: "test", plannedAmount: 1000.00)

    return BudgetDetailView(budget: budget)
        .modelContainer(for: Budget.self)
}
