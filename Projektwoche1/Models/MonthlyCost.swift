//
//  MonthlyCost.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 05.03.26.
//


import Foundation
import SwiftData


@Model
class MonthlyCost: Identifiable {
    
    var id = UUID()
    var name: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, amount: Double) {
        self.id = id
        self.name = name
        self.amount = amount
    }
    
}