//
//  Date+Extensions.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import Foundation

extension Date {
    // Returns the start of the month for a given date
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    }

    // Returns number of days in the month
    func numberOfDaysInMonth() -> Int {
        Calendar.current.range(of: .day, in: .month, for: self)!.count
    }

    // Returns first weekday (1 = Sunday, 2 = Monday, etc.)
    func firstWeekdayOfMonth() -> Int {
        Calendar.current.component(.weekday, from: startOfMonth())
    }
}
