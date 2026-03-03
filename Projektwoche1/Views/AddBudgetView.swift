//
//  AddBudgetView.swift
//  Projektwoche1
//
//  Created by Nils Adomeit on 02.03.26.
//
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
                TextField("Gib einen Budgetnamen ein ", text: $name)
                Text("Dein Budget")
                
                HStack {
                    Slider(value: $ammount, in: 0...1000, step: 10)
                    Text("\(Int(ammount)) €")
                        .bold()
                }
                
                Button("Speichern") {
                    
                    context.insert(Budget(
                        name: name,
                        plannedAmount: ammount)
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
