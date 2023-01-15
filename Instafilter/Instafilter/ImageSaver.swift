//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Андрей Коноплев on 12.01.2023.
//

import UIKit

class ImageSaver: NSObject {

    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)

    }

    @objc func saveCompleted(_ image: UIImage, didFinishSaveingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
