//
//  CoreDataConroller.swift
//  CoreDataProject
//
//  Created by Андрей Коноплев on 06.01.2023.
//

import CoreData

class CoreDataController: ObservableObject {

    let container = NSPersistentContainer(name: "CoreDataProject")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("fail load persistent store")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }

}
