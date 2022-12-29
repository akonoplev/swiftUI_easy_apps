//
//  SwiftUIViewGeometryReader.swift
//  Moonshot
//
//  Created by Андрей Коноплев on 27.12.2022.
//

import SwiftUI

struct SwiftUIViewGeometryReader: View {
    var body: some View {

        GeometryReader { geo in
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.8)
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        SwiftUIViewGeometryReader()
    }
}
