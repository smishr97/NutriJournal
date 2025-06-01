//
//  CalendarView.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @State private var currentMonth: Date = Date()

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack {
            // Month navigation
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(monthYearString)
                    .font(.headline)
                Spacer()
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // Weekday labels
            let weekdays = Calendar.current.shortWeekdaySymbols
            HStack {
                ForEach(weekdays, id: \ .self) { day in
                    Text(day)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                }
            }

            // Grid of days
            LazyVGrid(columns: columns, spacing: 10) {
                // Add empty cells for first weekday offset
                ForEach(0..<firstWeekdayOffset, id: \ .self) { _ in
                    Text("").frame(height: 40)
                }
                // Render days
                ForEach(1...daysInMonth, id: \ .self) { day in
                    let date = createDate(day: day)
                    Button(action: {
                        selectedDate = date
                    }) {
                        Text("\(day)")
                            .font(.body)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(isSameDay(date, selectedDate) ? Color.accentColor.opacity(0.3) : Color.clear)
                            .cornerRadius(6)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: currentMonth)
    }

    private var daysInMonth: Int {
        currentMonth.numberOfDaysInMonth()
    }

    private var firstWeekdayOffset: Int {
        currentMonth.firstWeekdayOfMonth() - 1
    }

    private func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }

    private func createDate(day: Int) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = day
        return Calendar.current.date(from: dateComponents)!    }

    private func isSameDay(_ a: Date, _ b: Date) -> Bool {
        Calendar.current.isDate(a, inSameDayAs: b)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(selectedDate: .constant(Date()))
    }
}
