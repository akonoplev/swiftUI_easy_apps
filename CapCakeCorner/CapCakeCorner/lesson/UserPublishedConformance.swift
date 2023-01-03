//
//  UserPublishedConformance.swift
//  CapCakeCorner
//
//  Created by Андрей Коноплев on 01.01.2023.
//

import Foundation

class User: ObservableObject, Codable {

    @Published
    var name = "Andrei Konoplev"

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }


    enum CodingKeys: CodingKey {
        case name
    }
}
