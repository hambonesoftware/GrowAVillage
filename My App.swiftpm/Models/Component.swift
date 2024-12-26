import SwiftData
import Foundation

@Model
class Component: Identifiable {
    @Attribute(.unique) var uniqueID: UUID = UUID()
    var id: UUID { uniqueID } // Computed property to conform to Identifiable
    
    @Attribute var name: String // Name of the component
    @Attribute var rawType: String // Raw type to persist ComponentType as a string
    
    // Enum to represent component types
    enum ComponentType: String, Codable {
        case input = "Input"
        case display = "Display"
    }
    
    // Computed property to map rawType to ComponentType
    var type: ComponentType {
        get {
            ComponentType(rawValue: rawType) ?? .input // Default to .input
        }
        set {
            rawType = newValue.rawValue
        }
    }
    
    // Relationship to parent project
    @Relationship var project: Project? // Many-to-one relationship (optional)
    
    // Default initializer for manual creation
    init(uniqueID: UUID = UUID(), name: String, type: ComponentType, project: Project? = nil) {
        self.uniqueID = uniqueID
        self.name = name
        self.rawType = type.rawValue
        self.project = project
    }
}
