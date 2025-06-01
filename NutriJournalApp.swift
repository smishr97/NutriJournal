import SwiftUI

@main
struct NutriJournalApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear {
                    logAppLaunch()
                    deferHeavyTasks()
                }
        }
    }

    private func logAppLaunch() {
        print("NutriJournal app launched successfully.")
    }

    private func deferHeavyTasks() {
        DispatchQueue.global(qos: .background).async {
            // Perform heavy tasks here, such as data preloading or analytics setup.
            print("Performing deferred tasks...")
        }
    }
}
