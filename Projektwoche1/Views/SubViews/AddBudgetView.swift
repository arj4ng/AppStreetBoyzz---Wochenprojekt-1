//
//  AddBudgetView.swift
//  Projektwoche1
//
//  Created by Nils Adomeit on 02.03.26.
// Test
import SwiftData
import SwiftUI

struct AddBudgetView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var ammount: Double = 0.0

    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    TextField("Gib einen Budgetnamen ein ", text: $name)
                    Divider()
                        .padding()
                        .underline()
                    
                    VStack {
                        HStack {
                            TextField(
                                "Betrag",
                                value: $ammount,
                                format: .number
                            )
                            .keyboardType(.decimalPad)
                            .padding(8)
                            Image(systemName: "eurosign")

                        }
                        Slider(value: $ammount, in: 0...3000, step: 50)
                    }
                }
                Button("Speichern") {

                    context.insert(
                        Budget(
                            name: name,
                            plannedAmount: ammount
                        )
                    )
                    dismiss()

                    name = ""
                    ammount = 0.0
                }
            }
            .contentMargins(.top, 0, for: .scrollContent)
            .navigationTitle("Budget")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddBudgetView()
}
