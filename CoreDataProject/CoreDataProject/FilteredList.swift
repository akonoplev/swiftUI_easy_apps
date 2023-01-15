//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Андрей Коноплев on 06.01.2023.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {

    @FetchRequest var fetchRequest: FetchedResults<T>

    let content: (T) -> Content

    init(keyName: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K BEGINSWITH %@", keyName, filterValue)
        )
        self.content = content

    }

    var body: some View {
        List(fetchRequest, id: \.self) { obj in
            self.content(obj)
        }
    }
}

extension Singer {
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}
