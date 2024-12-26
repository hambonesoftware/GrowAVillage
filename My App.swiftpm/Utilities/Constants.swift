import Foundation

struct Constants {
    // General app settings
    static let appName = "MyApp"
    static let defaultDateFormat = "yyyy-MM-dd"
    static let maxProgressValue: Double = 1.0
    static let minProgressValue: Double = 0.0
    
    // Regex patterns
    struct Regex {
        static let email = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        static let phoneNumber = "^\\d{3}-\\d{3}-\\d{4}$"
    }
    
    // Validation error messages
    struct ValidationMessages {
        static let emptyField = "This field cannot be empty."
        static let invalidEmail = "Please enter a valid email address."
        static let invalidPhoneNumber = "Please enter a valid phone number (e.g., 123-456-7890)."
    }
    
    // Default project settings
    struct Defaults {
        static let projectTitle = "Untitled Project"
        static let componentName = "Untitled Component"
    }
}
