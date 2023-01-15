//
//  DidSetStateView.swift
//  Instafilter
//
//  Created by Андрей Коноплев on 10.01.2023.
//

import SwiftUI

struct DidSetStateView: View {
    @State private var blurAmount: CGFloat = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { newValue in
                    print("New value is \(newValue)")
                }
        }
    }
}
