//
//  TextEditorExample.swift
//  Bookworm
//
//  Created by Андрей Коноплев on 03.01.2023.
//

import SwiftUI

struct TextEditorExample: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct TextEditorExample_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorExample()
    }
}
