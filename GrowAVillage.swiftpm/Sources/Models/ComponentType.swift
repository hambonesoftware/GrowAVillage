import Foundation

enum ComponentType: String, Codable {
    // Input Components
    case textInput
    case sliderInput
    case numberInput
    
    // Display Components
    case textDisplay
    case lineChart
    case calendarDisplay
    case progressBar
    
    // Default Component Type
    static var defaultType: ComponentType {
        return .textInput // Define the default component type
    }
}
