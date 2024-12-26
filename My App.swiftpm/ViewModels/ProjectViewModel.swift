import Foundation
import SwiftData

@MainActor
class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []
    
    private let context: ModelContext
    
    // Initializer accepting ModelContext as a dependency
    init(context: ModelContext) {
        self.context = context
    }
    
    // Load all projects
    func loadProjects() {
        do {
            let fetchDescriptor = FetchDescriptor<Project>()
            projects = try context.fetch(fetchDescriptor)
        } catch {
            print("Failed to load projects: \(error)")
        }
    }
    
    // Add a new project
    func addProject(title: String, projectDescription: String? = nil) {
        let newProject = Project(title: title, projectDescription: projectDescription)
        context.insert(newProject)
        saveContext()
    }
    
    // Delete a project
    func deleteProject(_ project: Project) {
        context.delete(project)
        saveContext()
    }
    
    // Update an existing project's title or description
    func updateProject(_ project: Project, title: String? = nil, projectDescription: String? = nil) {
        if let title = title {
            project.title = title
        }
        if let projectDescription = projectDescription {
            project.projectDescription = projectDescription
        }
        saveContext()
    }
    
    // Save changes to the database
    private func saveContext() {
        do {
            try context.save()
            print("Projects saved successfully.")
        } catch {
            print("Failed to save projects: \(error)")
        }
    }
}
