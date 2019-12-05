//
//  Entry+Convenience.swift
//  iOS Journal-CoreData
//
//  Created by Lambda_School_Loaner_201 on 12/4/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import Foundation
import CoreData

//, timestamp: Date = Date(), identifier: String = UUID().uuidString,
extension Entry {
    convenience init(title: String, bodyText: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
    }
}
