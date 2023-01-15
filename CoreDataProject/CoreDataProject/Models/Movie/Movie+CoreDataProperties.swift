//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Андрей Коноплев on 06.01.2023.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    public var wrappedTitle: String {
        return title ?? "Unknown title"
    }

    public var wrappedDirector: String {
        return director ?? "Unknown director"
    }

}

extension Movie : Identifiable {

}
