//
//  ImagePaint.swift
//  Drawing
//
//  Created by Андрей Коноплев on 30.12.2022.
//

import SwiftUI

struct ImagePaint: View {
    var body: some View {
        Capsule()
//            .strokeBorder(ImagePaint(image: Image("Example"),
//                               sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5) ,scale: 0.3),
//                    lineWidth: 20)
//            .frame(width: 300, height: 200)
    }
}

struct ImagePaint_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaint()
    }
}
