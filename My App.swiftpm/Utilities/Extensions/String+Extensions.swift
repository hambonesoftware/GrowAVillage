import Foundation

extension String {
    /// Trims whitespace and newline characters from a string
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Checks if a string is not empty after trimming
    var isNotEmpty: Bool {
        !self.trimmed.isEmpty
    }
    
    /// Converts a string to a UUID if possible
    var asUUID: UUID? {
        UUID(uuidString: self)
    }
    
    /// Validates if a string matches a regex pattern
    func matches(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
