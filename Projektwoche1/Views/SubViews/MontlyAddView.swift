//
//  MontlyAddView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 06.03.26.
//

import SwiftUI
import SwiftData


struct MontlyAddView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var name = ""
    @State  var amount: Double = 0.0
    var body: some View {
        VStack {
            TextField("Kostenname", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField(
                "Betrag",
                value: $amount,
                format: .number
            )
                .onSubmit { addCost() }
            .keyboardType(.decimalPad)
            Slider(value: $amount, in: 0...3000, step: 50)
            Button("Fixkosten hinzufügen") {
                addCost()
                
            }
            
            
        }.padding()
            
        
    }
    func addCost() {
            let value = amount 
            
            let cost = MonthlyCost(name: name, amount: value)
            context.insert(cost)
            
            name = ""
        amount = 0.0
            dismiss()
        }
}

#Preview {
    MontlyAddView()
}
