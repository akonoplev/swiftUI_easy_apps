//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Андрей Коноплев on 06.01.2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {

    @StateObject var coreDataController = CoreDataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
