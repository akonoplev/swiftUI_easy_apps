//
//  EmojiRationgView.swift
//  Bookworm
//
//  Created by Андрей Коноплев on 04.01.2023.
//

import SwiftUI

struct EmojiRationgView: View {

    var rating: Int16

    var body: some View {
        switch rating {
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        default:
            Text("5")
        }
    }
}

struct EmojiRationgView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRationgView(rating: 3)
    }
}
