//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Андрей Коноплев on 06.01.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "universe == %@", "Star Wars")
    ) var ships: FetchedResults<Ship>

    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Singer>

    @State var lastNameFilter = "A"

    var body: some View {
        FilteredList(keyName: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
        VStack {

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
