import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    @ObservedObject var project: Project
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(project.title)
                .font(.largeTitle)
            if let description = project.description {
                Text(description)
                    .font(.body)
            }
            NavigationLink("View Components", destination: ComponentListView())
        }
        .padding()
        .navigationTitle("Project Details")
    }
}
