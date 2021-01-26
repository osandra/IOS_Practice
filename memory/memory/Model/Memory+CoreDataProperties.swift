//
//  Memory+CoreDataProperties.swift
//  memory
//
//  Created by heawon on 2021/01/26.
//
//

import Foundation
import CoreData


extension Memory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memory> {
        return NSFetchRequest<Memory>(entityName: "Memory")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var parentPerson: Person?

}

extension Memory : Identifiable {

}
