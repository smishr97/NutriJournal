//
//  MealEntry+CoreDataProperties.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//
//

import Foundation
import CoreData


extension MealEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEntry> {
        return NSFetchRequest<MealEntry>(entityName: "MealEntry")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var mealType: String?
    @NSManaged public var details: MealDetail?

}

