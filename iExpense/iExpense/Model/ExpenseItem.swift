//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Андрей Коноплев on 25.12.2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double

    let currency: String
}
