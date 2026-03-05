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
    @State private var isEditing: Bool = false
    var budget: Budget
    @Environment(\.modelContext) private var context

    var body: some View {

        List {

            Section("Übersicht") {
                VStack(spacing: 20) {

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Budget")
                            Spacer()
                            if isEditing {
                                TextField(
                                    "Amount",
                                    value: Binding(
                                        get: { budget.plannedAmount },
                                        set: {
                                            budget.plannedAmount = $0
                                            try? context.save()
                                        }
                                    ),
                                    format: .number
                                )
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: 120)
                            } else {
                                Text(budget.plannedAmount, format: .currency(code: "EUR"))
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Verfügbar")
                            Spacer()
                            Text(budget.remainingAmount, format: .currency(code: "EUR"))
                                .foregroundStyle(
                                    budget.remainingAmount < budget.plannedAmount * 0.1 ? .red : .secondary
                                )
                        }

                        Gauge(value: budget.remainingAmount, in: 0...budget.plannedAmount) {
                            EmptyView()
                        }
                        .gaugeStyle(.accessoryLinearCapacity)
                        .tint(budget.remainingAmount < budget.plannedAmount * 0.1 ? .red : .green)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Ausgegeben")
                            Spacer()
                            Text(budget.totalSpent, format: .currency(code: "EUR"))
                                .foregroundStyle(.secondary)
                        }

                        Gauge(value: budget.totalSpent, in: 0...budget.plannedAmount) {
                            EmptyView()
                        }
                        .gaugeStyle(.accessoryLinearCapacity)
                    }

                }
            }
            
            Section {
              
                if budget.expenses.isEmpty {
                    Text("Keine Ausgaben vorhanden")
                        .foregroundStyle(.secondary)
                } else {

                    ForEach(budget.expenses) { expense in
                        HStack {
                            
                            Button {
                                expense.isPaid.toggle()
                                try? context.save()
                            } label: {
                                Image(systemName: expense.isPaid ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(expense.isPaid ? .green : .gray)
                                    .font(.title3)
                            }
                            .buttonStyle(.plain)
                            
                            VStack(alignment: .leading) {
                                if isEditing {
                                    TextField(
                                        "Title",
                                        text: Binding(
                                            get: { expense.title },
                                            set: {
                                                expense.title = $0
                                                try? context.save()
                                            }
                                        )
                                    )
                                    .textFieldStyle(.roundedBorder)
                                } else {
                                    Text(expense.title)
                                        .font(.headline)
                                        .strikethrough(expense.isPaid)
                                        .foregroundStyle(expense.isPaid ? .secondary : .primary)
                                }
                                if isEditing {
                                    TextField(
                                        "Info",
                                        text: Binding(
                                            get: { expense.info },
                                            set: {
                                                expense.info = $0
                                                try? context.save()
                                            }
                                        )
                                    )
                                    .textFieldStyle(.roundedBorder)
                                } else {
                                    Text(expense.info)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()

                            if isEditing {
                                TextField(
                                    "Amount",
                                    value: Binding(
                                        get: { expense.amount },
                                        set: {
                                            expense.amount = $0
                                            try? context.save()
                                        }
                                    ),
                                    format: .number
                                )
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: 100)
                            } else {
                                Text(
                                    expense.amount,
                                    format: .currency(code: "EUR")
                                )
                                .foregroundStyle(expense.isPaid ? .secondary : .primary)
                            }
                        }
                        
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteExpense(expense)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                            .tint(nil)
                        }
                    }
                    
                    
                }
            } header: {
                HStack {
                    Text("Ausgaben")
                    Spacer()
                    Button {
                        addExpense.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                }
                .frame(maxWidth: .infinity)
                .padding(.trailing, -4)
            }
        }

        .sheet(isPresented: $addExpense) {
            ExpenseAddView(budget: budget)
                .presentationDetents([.height(400), .large])
        }
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) {
                if isEditing {
                    TextField(
                        "Budget Name",
                        text: Binding(
                            get: { budget.name },
                            set: {
                                budget.name = $0
                                try? context.save()
                            }
                        )
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 200)
                } else {
                    Text(budget.name)
                        .font(.headline)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            }
        }
    }

    private func deleteExpense(_ expense: Expense) {
        context.delete(expense)
        try? context.save()
    }
        

}

#Preview {
    let budget = Budget(name: "test", plannedAmount: 1000.00)

    return BudgetDetailView(budget: budget)
        .modelContainer(for: Budget.self)
}
