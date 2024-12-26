import Foundation
import SwiftData

@MainActor
class InputComponentViewModel: ObservableObject {
    @Published var inputComponents: [InputComponent] = []
    
    private let context: ModelContext
    
    // Initializer
    init(context: ModelContext) {
        self.context = context
    }
    
    // Load all InputComponents
    func loadInputComponents() {
        do {
            let fetchDescriptor = FetchDescriptor<InputComponent>()
            inputComponents = try context.fetch(fetchDescriptor)
        } catch {
            print("Failed to load InputComponents: \(error)")
        }
    }
    
    // Add a new InputComponent
    func addInputComponent(name: String, currentValue: String, placeholder: String, toProject project: Project? = nil) {
        let newInputComponent = InputComponent(name: name, currentValue: currentValue, placeholder: placeholder, project: project)
        context.insert(newInputComponent)
        saveContext()
    }
    
    // Delete an InputComponent
    func deleteInputComponent(_ inputComponent: InputComponent) {
        context.delete(inputComponent)
        saveContext()
    }
    
    // Save changes
    private func saveContext() {
        do {
            try context.save()
            print("InputComponents saved successfully.")
        } catch {
            print("Failed to save InputComponents: \(error)")
        }
    }
}
