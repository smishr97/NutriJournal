//
//  DailyView.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import SwiftUI
import CoreData

struct DailyView: View {
    let date: Date
    @Environment(\ .managedObjectContext) private var viewContext
    @FetchRequest var mealEntries: FetchedResults<MealEntry>

    init(date: Date) {
        self.date = date
        let request: NSFetchRequest<MealEntry> = MealEntry.fetchRequest()
        // Predicate to fetch entries matching the date (ignoring time)
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: startOfDay)!
        request.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfDay as NSDate, endOfDay as NSDate)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MealEntry.mealType, ascending: true)]
        _mealEntries = FetchRequest(fetchRequest: request)
    }

    var body: some View {
        VStack {
            Text(dateTitle)
                .font(.title2)
                .padding(.top)

            List {
                ForEach(MealType.allCases) { mealType in
                    Section(header: Text(mealType.rawValue)) {
                        // Show existing entries for this meal type
                        let entriesForType = mealEntries.filter { $0.mealType == mealType.rawValue }
                        if entriesForType.isEmpty {
                            // Show button to add new
                            NavigationLink(destination: MealEntryEditView(date: date, mealType: mealType)) {
                                Text("Add \(mealType.rawValue)")
                                    .foregroundColor(.accentColor)
                            }
                        } else {
                            ForEach(entriesForType, id: \ .self) { entry in
                                NavigationLink(destination: MealEntryEditView(existingEntry: entry)) {
                                    Text(entry.details?.name ?? "")
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Meals")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var dateTitle: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(date: Date()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
