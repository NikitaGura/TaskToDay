//
//  PersistenceService.swift
//  TaskToday
//
//  Created by Nikita Gura on 06.12.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//

import Foundation
import CoreData

@available(iOS 10.0, *)
final class PersistenceSerivce{
    
    // MARK: - Core Data stack
    private init(){}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
   static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
