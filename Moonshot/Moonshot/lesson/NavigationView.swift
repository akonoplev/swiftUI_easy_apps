//
//  NavigationView.swift
//  Moonshot
//
//  Created by Андрей Коноплев on 27.12.2022.
//

import SwiftUI

struct NavigationView1: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("detailed row \(row)")
                        .padding()
                } label: {
                    Text("row \(row)")
                }
            }
            .navigationTitle("NavigationTitle")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
