//
//  MealDetail+CoreDataProperties.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//
//

import Foundation
import CoreData


extension MealDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealDetail> {
        return NSFetchRequest<MealDetail>(entityName: "MealDetail")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var category: String?
    @NSManaged public var additionalInfo: String?
    @NSManaged public var sideDishes: String?
    @NSManaged public var prepTimeMinutes: Int16
    @NSManaged public var cookTimeMinutes: Int16
    @NSManaged public var calories: Int16
    @NSManaged public var proteinGrams: Int16
    @NSManaged public var fatGrams: Int16
    @NSManaged public var sugarGrams: Int16
    @NSManaged public var entry: MealEntry?

}
