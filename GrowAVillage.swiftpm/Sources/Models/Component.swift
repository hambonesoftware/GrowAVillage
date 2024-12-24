import Foundation
import SwiftData

@Model
class Component: Identifiable {
    @Attribute(.unique) var id: UUID
    var type: ComponentType
    var title: String
    @Relationship var module: Module
    
    init(id: UUID = UUID(),
         type: ComponentType = ComponentType.defaultType, // Use default type
         title: String,
         module: Module = Module.defaultInstance) { // Use default module
        self.id = id
        self.type = type
        self.title = title
        self.module = module
    }
    
    required init(backingData: any BackingData<Component>) {
        self.id = backingData.id // Access backing data property directly
        self.type = backingData.type // Access type directly
        self.title = backingData.title // Access title directly
        self.module = backingData.module // Access module relationship directly
    }
}
