//
//  PointsOnMapView.swift
//  BucketList
//
//  Created by Андрей Коноплев on 17.01.2023.
//

import LocalAuthentication
import SwiftUI

struct TouchIdAndFaceId: View {

    @State private var isUnlocked = false


    var body: some View {
        VStack {
            if isUnlocked {
                Text("unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authentacate)
    }

    func authentacate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to inlock your data"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isSuccess, authError in
                if isSuccess {
                    isUnlocked = true
                } else {
                    // here is problem
                }
            }
        } else {
            print("here is no bometruy")
        }
    }
}
