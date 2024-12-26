import SwiftData
import Foundation

@Model
final class Project: ObservableObject, Identifiable {
    // MARK: - Properties
    @Attribute(.unique) var uniqueID: UUID = UUID() // Unique identifier for the project
    var id: UUID { uniqueID } // Conformance to Identifiable
    
    @Attribute var title: String = "Untitled Project" // Title of the project
    @Attribute var projectDescription: String? // Optional description of the project
    
    @Relationship(deleteRule: .cascade) var components: [DisplayComponent] = [] // Relationship to DisplayComponents
    @Relationship(deleteRule: .cascade) var inputs: [InputComponent] = [] // Relationship to InputComponents
    
    // MARK: - Initializers
    init(
        uniqueID: UUID = UUID(),
        title: String = "Untitled Project",
        projectDescription: String? = nil,
        components: [DisplayComponent] = [],
        inputs: [InputComponent] = []
    ) {
        self.uniqueID = uniqueID
        self.title = title
        self.projectDescription = projectDescription
        self.components = components
        self.inputs = inputs
    }
    
    // MARK: - Methods
    /// Add a new DisplayComponent to the project
    func addDisplayComponent(name: String, displayValue: String = "") {
        let newComponent = DisplayComponent(name: name, displayValue: displayValue, project: self)
        components.append(newComponent)
    }
    
    /// Add a new InputComponent to the project
    func addInputComponent(name: String, currentValue: String = "") {
        let newInput = InputComponent(name: name, currentValue: currentValue, project: self)
        inputs.append(newInput)
    }
    
    /// Remove a DisplayComponent from the project
    func removeDisplayComponent(_ component: DisplayComponent) {
        if let index = components.firstIndex(where: { $0.id == component.id }) {
            components.remove(at: index)
        }
    }
    
    /// Remove an InputComponent from the project
    func removeInputComponent(_ input: InputComponent) {
        if let index = inputs.firstIndex(where: { $0.id == input.id }) {
            inputs.remove(at: index)
        }
    }
}
