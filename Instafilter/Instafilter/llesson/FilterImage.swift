//
//  FilterImage.swift
//  Instafilter
//
//  Created by Андрей Коноплев on 11.01.2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct FilterImage: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFill()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)

        let ciContext = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1

        guard let outputImage = currentFilter.outputImage else {
            return
        }

        if let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }

    }
}

struct FilterImage_Previews: PreviewProvider {
    static var previews: some View {
        FilterImage()
    }
}
