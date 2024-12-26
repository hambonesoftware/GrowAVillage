import SwiftUI
import SwiftData

struct ProjectListView: View {
    @Query var projects: [Project]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects) { project in
                    NavigationLink(destination: ProjectDetailView(project: project)) {
                        Text(project.title)
                    }
                }
                .onDelete(perform: deleteProject)
            }
            .navigationTitle("Projects")
            .toolbar {
                NavigationLink("Add Project", destination: AddProjectView())
            }
        }
    }
    
    private func deleteProject(at offsets: IndexSet) {
        for index in offsets {
            context.delete(projects[index])
        }
        try? context.save()
    }
}
