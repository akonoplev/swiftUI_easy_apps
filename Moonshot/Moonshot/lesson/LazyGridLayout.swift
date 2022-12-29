//
//  LazyGridLayout.swift
//  Moonshot
//
//  Created by Андрей Коноплев on 28.12.2022.
//

import SwiftUI

struct LazyGridLayout: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("item \($0)")
                }
            }
        }
    }
}

struct LazyGridLayout_Previews: PreviewProvider {
    static var previews: some View {
        LazyGridLayout()
    }
}
