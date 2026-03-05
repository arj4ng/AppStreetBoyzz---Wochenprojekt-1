//
//  Recipt.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 05.03.26.
//

import Foundation
import SwiftData

@Model
class Recipt {

    var title: String
    var amount: Double
    var imageData: Data?

    init(title: String, amount: Double, imageData: Data? = nil) {
        self.title = title
        self.amount = amount
        self.imageData = imageData
    }
}
