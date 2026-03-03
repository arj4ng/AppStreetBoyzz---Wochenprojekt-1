//
//  ExpenseAddView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 03.03.26.
//

import SwiftUI

struct ExpenseAddView: View {
    @State var title = ""
    @State private var amount: Decimal = 12.34
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Titel", text: $title)
                TextField("Betrag", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Neue Ausgabe")
        }
    }
}
#Preview {
    ExpenseAddView()
}
