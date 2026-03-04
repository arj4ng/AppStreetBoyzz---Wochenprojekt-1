//
//  ProgressView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 03.03.26.
//


import SwiftUI

struct ProgressView: View {
  let budget: Budget
  private var progress: Double {
    guard budget.plannedAmount > 0 else { return 0 }
    return min(max(budget.totalSpent / budget.plannedAmount, 0), 1)
  }
  var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      HStack {
        Text("Budgetverbrauch")
          .font(.caption)
          .bold()
          .foregroundStyle(.secondary)
        Spacer()
        Text("\(Int(progress * 100))%")
          .font(.caption)
          .bold()
      }
      SwiftUI.ProgressView(value: progress)
        .tint(progress >= 0.9 ? .red : .green)
    }
  }
}
#Preview {
  let budget = Budget(name: "Haushalt", plannedAmount: 1000)
  return ProgressView(budget: budget)
    .padding()
}
