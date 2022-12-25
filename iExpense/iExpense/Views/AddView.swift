//
//  AddView.swift
//  iExpense
//
//  Created by Андрей Коноплев on 25.12.2022.
//

import SwiftUI

struct AddView: View {

    @Environment(\.dismiss) var dismiss

    @ObservedObject private var expense: Expenses

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"

    let types = ["Business", "Personal"]
    let currencies = ["USD", "RUB", "AUD"]

    init(expenses: Expenses) {
        self.expense = expenses
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                Picker("Currency", selection: $currency) {
                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                    expense.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
