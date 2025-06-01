import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to NutriJournal")
                    .font(.largeTitle)
                    .padding()
                // ...existing code...
            }
            .onAppear {
                print("ContentView appeared.")
            }
        }
    }
}