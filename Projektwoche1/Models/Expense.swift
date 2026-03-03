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
//    var date: Date
    var info: String
    @Relationship(inverse: \Budget.expenses)
    var budget: Budget

    init(
        id: UUID = UUID(),
        title: String,
        amount: Double,
//        date: Date,
        info: String,
        budget: Budget
    ) {
        self.id = id
        self.title = title
        self.amount = amount
//        self.date = date
        self.info = info
        self.budget = budget
    }
}
