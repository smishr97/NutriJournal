//
//  PersistenceController.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FoodJournal")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistenceController {
    static var preview: PersistenceController {
        let controller = PersistenceController(inMemory: true)
        // Add mock data here if needed for previews
        return controller
    }
}
