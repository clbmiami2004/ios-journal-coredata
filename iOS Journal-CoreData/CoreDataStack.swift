//
//  CoreDataStack.swift
//  iOS Journal-CoreData
//
//  Created by Lambda_School_Loaner_201 on 12/4/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let newContainer = NSPersistentContainer(name: "Entry")
        newContainer.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError("Failed to load persisten stores: \(error!)")
            }
        }
        return newContainer
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
