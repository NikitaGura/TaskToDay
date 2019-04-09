//
//  Status+CoreDataProperties.swift
//  TaskToday
//
//  Created by Nikita Gura on 08.12.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//
//

import Foundation
import CoreData


extension Status {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Status> {
        return NSFetchRequest<Status>(entityName: "Status")
    }

    @NSManaged public var name: String?
    @NSManaged public var task: Task?

}
