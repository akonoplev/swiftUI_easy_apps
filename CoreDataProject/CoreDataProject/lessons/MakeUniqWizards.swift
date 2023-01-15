//
//  MakeUniqWizards.swift
//  CoreDataProject
//
//  Created by Андрей Коноплев on 06.01.2023.
//

import SwiftUI

struct MakeUniqWizards: View {

    @Environment(\.managedObjectContext) var context

    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) {
                Text($0.name ?? "Unknown name")
            }
            Button("Add") {
                let wizard = Wizard(context: context)
                wizard.name = "Andrei"
            }

            Button("Save") {
                do {
                    try? context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct MakeUniqWizards_Previews: PreviewProvider {
    static var previews: some View {
        MakeUniqWizards()
    }
}
