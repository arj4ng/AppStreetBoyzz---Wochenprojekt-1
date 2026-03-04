//
//  ExpenseAddView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 03.03.26.
//

import SwiftUI
import SwiftData

struct ExpenseAddView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var title = ""
    @State var info = ""
    @State private var amount: Decimal  = 0.0
    var budget: Budget
    var body: some View {
        NavigationStack {
            List {
                TextField("Ausgabenname", text: $title)
                TextField("Infos", text: $info)
                HStack{
                    Text("Wieviel Bezahlt ?")
                    TextField("Betrag", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .padding(8)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(10)
                    Text("€")
                }
                
                Button("Speichern") {
                    
                    let newExpense = Expense(
                        title: title,
                        amount: NSDecimalNumber(decimal: amount).doubleValue,
                        info: info,
                        budget: budget,
                        isPaid: false
                    )
                    budget.expenses.append(newExpense)  
                    context.insert(newExpense)
                    dismiss()
                
                }
            }
            .navigationTitle("Neue Ausgabe")
        }
            
        }
    }

#Preview {
    ExpenseAddView( budget: Budget(name: "Essen", plannedAmount: 400))
}
