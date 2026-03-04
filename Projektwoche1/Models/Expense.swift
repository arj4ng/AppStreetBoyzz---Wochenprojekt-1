
//
//  Test 2.swift
//  Projektwoche1
//
//  Created by Alisan Aysanoglu-Hollschwandner on 02.03.26.
//

import Foundation
import SwiftData

@Model
class Expense: Identifiable {
    var id = UUID()
    var title: String
    var amount: Double
    var info: String
    @Relationship(inverse: \Budget.expenses)
    var budget: Budget
    var isPaid: Bool = false

    init(
        id: UUID = UUID(),
        title: String,
        amount: Double,
        info: String,
        budget: Budget,
        isPaid: Bool
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.info = info
        self.budget = budget
        self.isPaid = isPaid
    }
}
