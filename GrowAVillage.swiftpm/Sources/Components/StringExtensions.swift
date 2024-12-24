import Foundation

extension String {
    
    /// Trims whitespace and newline characters from both ends of the string.
    /// - Returns: A new string with trimmed characters.
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Checks if the string contains only alphanumeric characters.
    /// - Returns: `true` if the string is alphanumeric, `false` otherwise.
    func isAlphanumeric() -> Bool {
        let regex = "^[A-Za-z0-9]+$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// Converts the string to a title-cased version.
    /// - Returns: A new string with the first letter of each word capitalized.
    func toTitleCase() -> String {
        return self.capitalized
    }
    
    /// Validates if the string is a valid URL.
    /// - Returns: `true` if the string is a valid URL, `false` otherwise.
    func isValidURL() -> Bool {
        return URL(string: self) != nil
    }
    
    /// Replaces all occurrences of a substring with another substring.
    /// - Parameters:
    ///   - target: The substring to be replaced.
    ///   - replacement: The substring to replace with.
    /// - Returns: A new string with the replacements applied.
    func replacingOccurrences(of target: String, with replacement: String) -> String {
        return self.replacingOccurrences(of: target, with: replacement)
    }
    
    // Add more string utility functions as needed
}
