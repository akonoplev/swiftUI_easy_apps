//
//  EditView.swift
//  BucketList
//
//  Created by Андрей Коноплев on 17.01.2023.
//

import SwiftUI

struct EditView: View {

    @Environment(\.dismiss) var dismiss
    var location: ContentView.Location

    @State private var name: String
    @State private var description: String

    var onSave: (ContentView.Location) -> Void

    init(location: ContentView.Location,
         onSave: @escaping (ContentView.Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Text Field", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place detailes")
            .toolbar {
                Button("Save") {

                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
}
