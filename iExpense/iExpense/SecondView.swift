//
//  SecondView.swift
//  iExpense
//
//  Created by Андрей Коноплев on 25.12.2022.
//

import SwiftUI

struct SecondView: View {

    @Environment(\.dismiss) var dismiss

    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    let name: String
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }

    }

    private func removeRows(at offset: IndexSet) {
        numbers.remove(atOffsets: offset)
    }
}
