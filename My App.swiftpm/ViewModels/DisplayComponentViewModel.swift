import Foundation
import SwiftData

@MainActor
class DisplayComponentViewModel: ObservableObject {
    @Published var displayComponents: [DisplayComponent] = []
    
    private let context: ModelContext
    
    // Initializer
    init(context: ModelContext) {
        self.context = context
    }
    
    // Load all DisplayComponents
    func loadDisplayComponents() {
        do {
            let fetchDescriptor = FetchDescriptor<DisplayComponent>()
            displayComponents = try context.fetch(fetchDescriptor)
        } catch {
            print("Failed to load DisplayComponents: \(error)")
        }
    }
    
    // Add a new DisplayComponent
    func addDisplayComponent(name: String, displayValue: String, toProject project: Project? = nil) {
        let newDisplayComponent = DisplayComponent(name: name, displayValue: displayValue, project: project)
        context.insert(newDisplayComponent)
        saveContext()
    }
    
    // Delete a DisplayComponent
    func deleteDisplayComponent(_ displayComponent: DisplayComponent) {
        context.delete(displayComponent)
        saveContext()
    }
    
    // Save changes
    private func saveContext() {
        do {
            try context.save()
            print("DisplayComponents saved successfully.")
        } catch {
            print("Failed to save DisplayComponents: \(error)")
        }
    }
}
