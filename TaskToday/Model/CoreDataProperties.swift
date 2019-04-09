//
//  Task+CoreDataProperties.swift
//  TaskToday
//
//  Created by Nikita Gura on 08.12.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var text: String?
    @NSManaged public var status: Status?

}
