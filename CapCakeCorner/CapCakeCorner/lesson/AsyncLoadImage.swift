//
//  AsyncLoadImage.swift
//  CapCakeCorner
//
//  Created by Андрей Коноплев on 01.01.2023.
//

import SwiftUI

struct AsyncLoadImage: View {

    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct AsyncLoadImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncLoadImage()
    }
}
