//
//  SummaryView.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import SwiftUI

struct SummaryView: View {
    enum RangeType: String, CaseIterable, Identifiable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"

        var id: String { rawValue }
    }

    @State private var selectedRange: RangeType = .daily
    @State private var referenceDate: Date = Date()
    @Environment(\ .managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            Picker("Range", selection: $selectedRange) {
                ForEach(RangeType.allCases) { range in
                    Text(range.rawValue).tag(range)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            DatePicker("Reference Date", selection: $referenceDate, displayedComponents: [.date])
                .datePickerStyle(CompactDatePickerStyle())
                .padding(.horizontal)

            Spacer()

            VStack(alignment: .leading, spacing: 10) {
                Text("Totals for \(selectedRange.rawValue) ending \(formattedDate(referenceDate))")
                    .font(.headline)
                let totals = calculateTotals()
                Text("Calories: \(totals.calories) kcal")
                Text("Protein: \(totals.protein) g")
                Text("Fats: \(totals.fats) g")
                Text("Sugar: \(totals.sugar) g")
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Summary")
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    private func calculateTotals() -> MacroTotals {
        switch selectedRange {
        case .daily:
            return MacroCalculator.totals(for: referenceDate, context: viewContext)
        case .weekly:
            var combined = MacroTotals()
            for offset in 0..<7 {
                if let day = Calendar.current.date(byAdding: .day, value: -offset, to: referenceDate) {
                    let dayTotals = MacroCalculator.totals(for: day, context: viewContext)
                    combined.calories += dayTotals.calories
                    combined.protein += dayTotals.protein
                    combined.fats += dayTotals.fats
                    combined.sugar += dayTotals.sugar
                }
            }
            return combined
        case .monthly:
            var combined = MacroTotals()
            let range = Calendar.current.range(of: .day, in: .month, for: referenceDate)!
            let components = Calendar.current.dateComponents([.year, .month], from: referenceDate)
            for day in range {
                var dc = DateComponents()
                dc.year = components.year
                dc.month = components.month
                dc.day = day
                if let date = Calendar.current.date(from: dc) {
                    let dayTotals = MacroCalculator.totals(for: date, context: viewContext)
                    combined.calories += dayTotals.calories
                    combined.protein += dayTotals.protein
                    combined.fats += dayTotals.fats
                    combined.sugar += dayTotals.sugar
                }
            }
            return combined
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView().environment(\ .managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
