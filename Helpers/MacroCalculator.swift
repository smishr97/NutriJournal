//
//  MacroCalculator.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import Foundation
import CoreData

struct MacroTotals {
    var calories: Int = 0
    var protein: Int = 0
    var fats: Int = 0
    var sugar: Int = 0
}

class MacroCalculator {
    static func totals(for date: Date, context: NSManagedObjectContext) -> MacroTotals {
        // Fetch MealEntry objects for the given date
        let fetch: NSFetchRequest<MealEntry> = MealEntry.fetchRequest()
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: startOfDay)!
        fetch.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfDay as NSDate, endOfDay as NSDate)

        do {
            let entries = try context.fetch(fetch)
            var totals = MacroTotals()
            for entry in entries {
                if let details = entry.details {
                    totals.calories += Int(details.calories)
                    totals.protein += Int(details.proteinGrams)
                    totals.fats += Int(details.fatGrams)
                    totals.sugar += Int(details.sugarGrams)
                }
            }
            return totals
        } catch {
            print("Error fetching macros: \(error)")
            return MacroTotals()
        }
    }
}
