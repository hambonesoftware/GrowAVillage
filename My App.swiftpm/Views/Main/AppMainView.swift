import SwiftUI
import SwiftData

struct AppMainView: View {
    var body: some View {
        TabView {
            NavigationView {
                ProjectListView()
            }
            .tabItem {
                Label("Projects", systemImage: "folder")
            }
            
            NavigationView {
                ComponentListView()
            }
            .tabItem {
                Label("Components", systemImage: "square.stack")
            }
        }
    }
}
