//
//  DataController.swift
//  Bookworm
//
//  Created by Андрей Коноплев on 03.01.2023.
//

import CoreData

class DataController: ObservableObject {

    let container = NSPersistentContainer(name: "Bookworm")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("fail load persistent store")
            }
        }
    }

}
