//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Андрей Коноплев on 03.01.2023.
//

import SwiftUI

@main
struct BookwormApp: App {

    @StateObject private var dataContoller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataContoller.container.viewContext)
        }
    }
}
