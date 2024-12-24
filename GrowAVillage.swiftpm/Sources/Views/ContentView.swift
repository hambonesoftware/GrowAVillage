import SwiftUI

/// The main entry point for the app
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("View Pages", destination: PageListView(
                    pages: [Page(title: "Page 1"), Page(title: "Page 2")],
                    onPageSelected: { _ in },
                    onDeletePage: { _ in }
                ))
                .padding()
                
                NavigationLink("View Modules", destination: ModuleListView(
                    modules: [Module(name: "Module 1"), Module(name: "Module 2")],
                    onModuleSelected: { _ in },
                    onDeleteModule: { _ in }
                ))
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
