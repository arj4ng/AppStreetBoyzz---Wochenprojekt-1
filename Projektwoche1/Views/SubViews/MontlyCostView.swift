//
//  MontlyCostView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 05.03.26.
//

//
//  MonthlyCostView.swift
//  Projektwoche1
//
//  Created by Alisan Aysanoglu-Hollschwandner on 05.03.26.
//

import SwiftUI
import SwiftData

struct MonthlyCostView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \MonthlyCost.name)
    private var costs: [MonthlyCost]
    
    @State private var name = ""
    @State private var amount = ""
    @State private var showSheet: Bool = false
    var totalCosts: Double {
        costs.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("Fixkosten gesamt: \(totalCosts, format: .currency(code: "EUR"))")
                    .font(.headline)
                    .padding()
                
                List {
                    ForEach(costs) { cost in
                        HStack {
                            Text(cost.name)
                            
                            Spacer()
                            
                            Text(cost.amount, format: .currency(code: "EUR"))
                        }
                    }
                    .onDelete(perform: deleteCost)
                }
                
                VStack {
                    TextField("Kostenname", text: $name)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Betrag", text: $amount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit { addCost() }
                    
                    Button("Fixkosten hinzufügen") {
                        addCost()
                        
                    }
                    
                    .buttonStyle(.borderedProminent)
                    
                }
                
                .padding()
            }
        
            .navigationTitle("Fixkosten")
            
        }
        
    }
    
    func addCost() {
            guard let value = Double(amount) else { return }
            
            let cost = MonthlyCost(name: name, amount: value)
            context.insert(cost)
            
            name = ""
            amount = ""
        }
    
    func deleteCost(at offsets: IndexSet) {
        for index in offsets {
            context.delete(costs[index])
        }
    }
    
}

#Preview {
    MonthlyCostView()
}
