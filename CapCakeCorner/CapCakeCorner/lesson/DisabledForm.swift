//
//  DisabledForm.swift
//  CapCakeCorner
//
//  Created by Андрей Коноплев on 01.01.2023.
//

import SwiftUI

struct DisabledForm: View {
    @State private var username = ""
    @State private var email = ""

    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
                .disabled(disableForm)
            }
        }
    }
}
