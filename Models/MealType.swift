//
//  MealType.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import Foundation

enum MealType: String, CaseIterable, Identifiable {
    case breakfast = "Breakfast"
    case lunch     = "Lunch"
    case snack     = "Snack"
    case dinner    = "Dinner"

    var id: String { rawValue }
}
