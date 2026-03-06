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
                

                

            }
            .toolbar {
              ToolbarItem(placement: .topBarTrailing) {
                Button {
                  showSheet = true
                } label: {
                  Image(systemName: "plus")
                }
              }
            }
            .sheet(isPresented: $showSheet) {
                MontlyAddView()
                    .presentationDetents([.height(400), .large])
            }
            .navigationTitle("Fixkosten")
            .navigationBarTitleDisplayMode(.inline)
            
        }

        
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
