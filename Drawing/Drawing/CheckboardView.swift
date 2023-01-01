//
//  CheckboardView.swift
//  Drawing
//
//  Created by Андрей Коноплев on 30.12.2022.
//

import SwiftUI

struct Checkerboard: Shape {
    var rows: Int
    var columes: Int

    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columes))
        }

        set {
            rows = Int(newValue.first)
            columes = Int(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columes)

        for row in 0..<rows {
            for column in 0..<columes {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct CheckboardView: View {

    @State private var rows = 4
    @State private var columns = 4


    var body: some View {
        Checkerboard(rows: rows, columes: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
    }
}

struct CheckboardView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboardView()
    }
}
