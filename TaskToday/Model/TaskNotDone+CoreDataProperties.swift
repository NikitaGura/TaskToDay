//
//  TaskNotDone+CoreDataProperties.swift
//  TaskToday
//
//  Created by Nikita Gura on 09.12.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskNotDone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskNotDone> {
        return NSFetchRequest<TaskNotDone>(entityName: "TaskNotDone")
    }

    @NSManaged public var text: String?
    @NSManaged public var dateFrom: NSDate?
    @NSManaged public var dateTo: NSDate?

}
