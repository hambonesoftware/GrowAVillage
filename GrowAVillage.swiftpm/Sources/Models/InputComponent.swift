import Foundation
import SwiftData

@Model
final class InputComponent: Component {
    // Common input properties
    var currentValue: String
    var placeholder: String
    
    // For slider inputs
    var minValue: Double?
    var maxValue: Double?
    var step: Double?
    
    // For number inputs
    var numberValue: Int?
    
    // Initializers for different input types
    init(id: UUID = UUID(),
         type: ComponentType,
         title: String,
         module: Module,
         currentValue: String = "",
         placeholder: String = "",
         minValue: Double? = nil,
         maxValue: Double? = nil,
         step: Double? = nil,
         numberValue: Int? = nil) {
        
        self.currentValue = currentValue
        self.placeholder = placeholder
        self.minValue = minValue
        self.maxValue = maxValue
        self.step = step
        self.numberValue = numberValue
        super.init(id: id, type: type, title: title, module: module)
    }
    
    required init(backingData: any BackingData<Component>) {
        // Initialize properties specific to InputComponent
        self.currentValue = backingData["currentValue"] as? String ?? ""
        self.placeholder = backingData["placeholder"] as? String ?? ""
        self.minValue = backingData["minValue"] as? Double
        self.maxValue = backingData["maxValue"] as? Double
        self.step = backingData["step"] as? Double
        self.numberValue = backingData["numberValue"] as? Int
        
        // Call the parent initializer
        super.init(backingData: backingData)
    }
    
    override var persistentBackingData: any BackingData<Component> {
        get {
            var data = super.persistentBackingData
            // Add InputComponent-specific properties
            data["currentValue"] = currentValue
            data["placeholder"] = placeholder
            data["minValue"] = minValue
            data["maxValue"] = maxValue
            data["step"] = step
            data["numberValue"] = numberValue
            return data
        }
        set {
            // Update InputComponent-specific properties
            currentValue = newValue["currentValue"] as? String ?? ""
            placeholder = newValue["placeholder"] as? String ?? ""
            minValue = newValue["minValue"] as? Double
            maxValue = newValue["maxValue"] as? Double
            step = newValue["step"] as? Double
            numberValue = newValue["numberValue"] as? Int
            
            // Call the parent setter
            super.persistentBackingData = newValue
        }
    }
}
