import Foundation

struct ValidationHelper {
    /// Validates that a string is not empty
    static func validateNotEmpty(_ value: String, fieldName: String) -> Bool {
        if value.trimmed.isEmpty {
            print("\(fieldName) must not be empty.")
            return false
        }
        return true
    }
    
    /// Validates that a number is within a range
    static func validateRange<T: Comparable>(_ value: T, min: T, max: T, fieldName: String) -> Bool {
        if value < min || value > max {
            print("\(fieldName) must be between \(min) and \(max).")
            return false
        }
        return true
    }
    
    /// Validates that a string matches a regex pattern
    static func validateRegex(_ value: String, regex: String, fieldName: String) -> Bool {
        if !value.matches(regex: regex) {
            print("\(fieldName) is invalid.")
            return false
        }
        return true
    }
}
