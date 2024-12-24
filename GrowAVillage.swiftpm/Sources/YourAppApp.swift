import SwiftUI

@main
struct YourAppApp: App {
    // App's body defines the scene
    var body: some Scene {
        WindowGroup {
            // The initial view for your app
            ContentView()
                .environmentObject(ContentViewModel()) // Inject the main ViewModel
        }
    }
}
