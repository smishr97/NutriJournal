//
//  ContentView.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate: Date = Date()

    var body: some View {
        NavigationView {
            VStack {
                // Calendar at top
                CalendarView(selectedDate: $selectedDate)
                    .padding(.top)

                // Button to go to DailyView for selectedDate
                NavigationLink(destination: DailyView(date: selectedDate)) {
                    Text("View Meals for \(formattedDate(selectedDate))")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                NavigationLink(destination: SummaryView()) {
                    Text("View Summary")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("NutriJournal")
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
