import SwiftUI
import SwiftData

struct AddProjectView: View {
    @Environment(\.modelContext) private var context
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Project Details")) {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            Button("Add Project") {
                let newProject = Project(title: title, projectDescription: description)
                context.insert(newProject)
                try? context.save()
            }
        }
        .navigationTitle("Add Project")
    }
}
