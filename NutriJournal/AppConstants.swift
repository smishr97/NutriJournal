//
//  AppConstants.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//


import SwiftUI

struct AppConstants {
    // MARK: - Colors (Matching your web app)
    struct Colors {
        static let primary = Color(red: 0.4, green: 0.72, blue: 0.69) // Muted Teal
        static let secondary = Color(red: 0.9, green: 0.9, blue: 0.98) // Light lavender
        static let accent = Color(red: 0.82, green: 0.94, blue: 0.75) // Muted green
        static let background = Color(red: 0.97, green: 0.97, blue: 1.0) // Off-white
        static let cardBackground = Color.white
        static let textPrimary = Color(red: 0.15, green: 0.15, blue: 0.2)
        static let textSecondary = Color(red: 0.5, green: 0.5, blue: 0.6)
        
        // Chart colors
        static let caloriesColor = Color(red: 1.0, green: 0.3, blue: 0.3)
        static let proteinColor = Color(red: 0.2, green: 0.8, blue: 0.2)
        static let fatsColor = Color(red: 1.0, green: 0.6, blue: 0.0)
        static let sugarColor = Color(red: 0.5, green: 0.3, blue: 0.8)
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // MARK: - Meal Types & Categories
    static let mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner"]
    static let mealCategories = [
        "General", "Vegetarian", "Vegan", "Protein Rich", 
        "Low Carb", "Keto", "Paleo", "Gluten Free", "Dairy Free"
    ]
    
    // MARK: - Animation
    struct Animation {
        static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let spring = SwiftUI.Animation.spring(response: 0.5, dampingFraction: 0.8)
    }
}