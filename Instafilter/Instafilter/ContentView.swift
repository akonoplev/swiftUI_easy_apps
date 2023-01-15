//
//  ContentView.swift
//  Instafilter
//
//  Created by Андрей Коноплев on 10.01.2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {

    @State private var image: Image?
    @State private var filterInesity = 0.5

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @State private var showingFilterDialog = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                HStack {
                    Text("intensity")
                    Slider(value: $filterInesity)
                        .onChange(of: filterInesity) { _ in
                            applyProcessing()
                        }
                }
                .padding(.vertical)

                HStack {
                    Button("Change filter") {
                        showingFilterDialog = true
                    }

                    Spacer()

                    Button("Save", action: save)
                        .disabled(processedImage == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Insta filter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select filter", isPresented: $showingFilterDialog) {
                Button("Crystalize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func save() {
        guard let processedImage = processedImage else { return }

        let imageSaver = ImageSaver()

        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = { error in
            print("failed: \(error)")
        }

        imageSaver.writeToPhotoAlbum(image: processedImage)
    }

    func applyProcessing() {

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterInesity, forKey: kCIInputIntensityKey)
        }

        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterInesity * 200, forKey: kCIInputRadiusKey)
        }

        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(filterInesity * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else {
            return
        }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            processedImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
