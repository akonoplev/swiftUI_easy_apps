//
//  ContentView.swift
//  iExpense
//
//  Created by Андрей Коноплев on 24.12.2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject
    var expenses = Expenses()

    @State private var showindAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    HStack {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)

                        Spacer()
                        Text(item.amount, format: .currency(code: item.currency))
                    }
                }.onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showindAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showindAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
