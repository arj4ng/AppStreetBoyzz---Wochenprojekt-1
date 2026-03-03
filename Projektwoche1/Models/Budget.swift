//
//  Budget.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 02.03.26.
//

import Foundation
import SwiftData

@Model
class Budget:Identifiable{
    var id = UUID()
    var name: String
    var plannedAmount: Double
    var expenses: [Expense] = []
    
    init(id: UUID = UUID(), name: String, plannedAmount: Double) {
        self.id = id
        self.name = name
        self.plannedAmount = plannedAmount
    }
    var totalSpent: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var remainingAmount: Double {
        plannedAmount - totalSpent
    }
}
