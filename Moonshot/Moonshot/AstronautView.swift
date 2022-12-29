//
//  AstronautView.swift
//  Moonshot
//
//  Created by Андрей Коноплев on 29.12.2022.
//

import SwiftUI

struct AstronautView: View {

    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
