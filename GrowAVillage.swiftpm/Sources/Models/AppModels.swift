import Foundation
import SwiftData

enum AppModels {
    @Model
    class Page: Identifiable {
        @Attribute(.unique) var id: UUID = UUID()
        var title: String // Changed to var to allow mutation
        
        init(title: String) {
            self.title = title
        }
        
        // Default initializer for SwiftData compatibility
        required init() {
            self.title = "Untitled Page"
        }
    }
    
    @Model
    class Module: Identifiable {
        @Attribute(.unique) var id: UUID = UUID()
        var name: String // Changed to var to allow mutation
        var associatedPageID: UUID
        
        init(name: String, associatedPageID: UUID) {
            self.name = name
            self.associatedPageID = associatedPageID
        }
        
        // Default initializer for SwiftData compatibility
        required init() {
            self.name = "Untitled Module"
            self.associatedPageID = UUID() // Provide a default UUID
        }
        
        // Add a static property for the default instance
        static let defaultInstance: Module = Module(name: "Default Module", associatedPageID: UUID())
    }
}
