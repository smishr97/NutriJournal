//
//  NutriJournalApp.swift
//  NutriJournal
//
//  Created by Shivam Mishra on 5/31/25.
//

import SwiftUI

@main
struct NutriJournalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
