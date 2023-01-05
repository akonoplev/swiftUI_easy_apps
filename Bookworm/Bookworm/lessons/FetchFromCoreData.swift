//
//  FetchFromCoreData.swift
//  Bookworm
//
//  Created by Андрей Коноплев on 04.01.2023.
//

import SwiftUI

//struct FetchFromCoreData: View {
//    @Environment(\.managedObjectContext) var context
//    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
//
//    @AppStorage("notes") private var notes = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List(students) {
//                    Text($0.name ?? "Unknown")
//                }
//
//                Button("Add") {
//                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
//                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
//
//                    let chosenFirstName = firstNames.randomElement()!
//                    let chosenLastName = lastNames.randomElement()!
//
//                    let student = Student(context: context)
//                    student.id = UUID()
//                    student.name = "\(chosenFirstName) \(chosenLastName)"
//
//                    try? context.save()
//                }
//            }
//        }
//    }
//}

//struct FetchFromCoreData_Previews: PreviewProvider {
//    static var previews: some View {
//        FetchFromCoreData()
//    }
//}
