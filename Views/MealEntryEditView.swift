//
//  MealEntryEditView.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import SwiftUI
import CoreData

struct MealEntryEditView: View {
    @Environment(\ .managedObjectContext) private var viewContext
    @Environment(\ .presentationMode) var presentationMode

    // For editing existing entry
    var existingEntry: MealEntry?

    // For new entry
    let date: Date?
    let mealType: MealType?

    // State variables for MealEntry fields
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var additionalInfo: String = ""
    @State private var sideDishes: String = ""
    @State private var prepTimeMinutes: Int = 0
    @State private var cookTimeMinutes: Int = 0
    @State private var calories: Int = 0
    @State private var proteinGrams: Int = 0
    @State private var fatGrams: Int = 0
    @State private var sugarGrams: Int = 0
    
    // If editing, reference the existing details
    @State private var detailObject: MealDetails?

    init(date: Date, mealType: MealType) {
        self.date = date
        self.mealType = mealType
        self.existingEntry = nil
    }

    init(existingEntry: MealEntry) {
        self.existingEntry = existingEntry
        self.date = nil
        self.mealType = MealType(rawValue: existingEntry.mealType ?? "")
        if let details = existingEntry.details {
            _name = State(initialValue: details.name ?? "")
            _category = State(initialValue: details.category ?? "")
            _additionalInfo = State(initialValue: details.additionalInfo ?? "")
            _sideDishes = State(initialValue: details.sideDishes ?? "")
            _prepTimeMinutes = State(initialValue: Int(details.prepTimeMinutes))
            _cookTimeMinutes = State(initialValue: Int(details.cookTimeMinutes))
            _calories = State(initialValue: Int(details.calories))
            _proteinGrams = State(initialValue: Int(details.proteinGrams))
            _fatGrams = State(initialValue: Int(details.fatGrams))
            _sugarGrams = State(initialValue: Int(details.sugarGrams))
            _detailObject = State(initialValue: details)
        }
    }

    var body: some View {
        Form {
            Section(header: Text("Meal Details")) {
                TextField("Name of Meal", text: $name)
                TextField("Category", text: $category)
                TextField("Additional Info", text: $additionalInfo)
                TextField("Side Dishes", text: $sideDishes)
            }
            Section(header: Text("Time (Minutes)")) {
                Stepper(value: $prepTimeMinutes, in: 0...300, step: 1) {
                    Text("Prep Time: \(prepTimeMinutes) min")
                }
                Stepper(value: $cookTimeMinutes, in: 0...300, step: 1) {
                    Text("Cook Time: \(cookTimeMinutes) min")
                }
            }
            Section(header: Text("Macronutrients")) {
                Stepper(value: $calories, in: 0...2000, step: 10) {
                    Text("Calories: \(calories) kcal")
                }
                Stepper(value: $proteinGrams, in: 0...200, step: 1) {
                    Text("Protein: \(proteinGrams) g")
                }
                Stepper(value: $fatGrams, in: 0...200, step: 1) {
                    Text("Fat: \(fatGrams) g")
                }
                Stepper(value: $sugarGrams, in: 0...200, step: 1) {
                    Text("Sugar: \(sugarGrams) g")
                }
            }
        }
        .navigationTitle(existingEntry == nil ? "Add Meal" : "Edit Meal")
        .navigationBarItems(trailing: Button("Save") { saveEntry() })
        .onAppear { loadExistingData() }
    }

    private func loadExistingData() {
        // Values are already initialized in init for existingEntry
    }

    private func saveEntry() {
        // Create or update MealEntry
        let entryObject = existingEntry ?? MealEntry(context: viewContext)
        entryObject.id = existingEntry?.id ?? UUID()

        if let date = date {
            entryObject.date = Calendar.current.startOfDay(for: date)
        }
        if let mealType = mealType {
            entryObject.mealType = mealType.rawValue
        }

        // Create or update MealDetails
        let detail = detailObject ?? MealDetails(context: viewContext)
        detail.id = detailObject?.id ?? UUID()
        detail.name = name
        detail.category = category
        detail.additionalInfo = additionalInfo
        detail.sideDishes = sideDishes
        detail.prepTimeMinutes = Int16(prepTimeMinutes)
        detail.cookTimeMinutes = Int16(cookTimeMinutes)
        detail.calories = Int16(calories)
        detail.proteinGrams = Int16(proteinGrams)
        detail.fatGrams = Int16(fatGrams)
        detail.sugarGrams = Int16(sugarGrams)

        // Link details with entry
        entryObject.details = detail
        detail.entry = entryObject

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving meal entry or details: \(error.localizedDescription)")
        }
    }
}

struct MealEntryEditView_Previews: PreviewProvider {
    static var previews: some View {
        MealEntryEditView(date: Date(), mealType: .breakfast)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
