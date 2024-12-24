import Foundation

struct DateHelper {
    
    /// Formats a `Date` object into a string with the specified format.
    /// - Parameters:
    ///   - date: The `Date` to format.
    ///   - format: The date format string.
    /// - Returns: A formatted date string.
    static func formatDate(_ date: Date, format: String = "MMM d, yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// Parses a date string into a `Date` object with the specified format.
    /// - Parameters:
    ///   - dateString: The date string to parse.
    ///   - format: The date format string.
    /// - Returns: A `Date` object if parsing is successful, otherwise `nil`.
    static func parseDate(_ dateString: String, format: String = "MMM d, yyyy") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
    
    /// Calculates the number of days between two dates.
    /// - Parameters:
    ///   - start: The start date.
    ///   - end: The end date.
    /// - Returns: The number of days between the two dates.
    static func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
    
    /// Returns the start of the current day.
    /// - Returns: A `Date` representing the start of today.
    static func startOfToday() -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    /// Returns the end of the current day.
    /// - Returns: A `Date` representing the end of today.
    static func endOfToday() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfToday()) ?? Date()
    }
    
    // Add more date utility functions as needed
}
