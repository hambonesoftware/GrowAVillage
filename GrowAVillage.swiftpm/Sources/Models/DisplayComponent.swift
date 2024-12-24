import Foundation
import SwiftData

@Model
final class DisplayComponent: Component {
    // Common display properties
    var displayValue: String // Can be adapted based on display type
    
    // For charts
    var dataPoints: [Double]?
    
    // For calendar display
    var selectedDate: Date?
    
    // For progress bar
    var progress: Double? // Value between 0.0 and 1.0
    
    // Initializers for different display types
    init(id: UUID = UUID(),
         type: ComponentType,
         title: String,
         module: Module,
         displayValue: String = "",
         dataPoints: [Double]? = nil,
         selectedDate: Date? = nil,
         progress: Double? = nil) {
        
        self.displayValue = displayValue
        self.dataPoints = dataPoints
        self.selectedDate = selectedDate
        self.progress = progress
        super.init(id: id, type: type, title: title, module: module)
    }
}
