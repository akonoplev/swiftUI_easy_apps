//
//  extension FIleManager.swift
//  BucketList
//
//  Created by Andrei Konoplev on 20/1/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
