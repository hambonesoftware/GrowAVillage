import Foundation

extension Date {
    /// Formats a date as a string in a readable format
    func formatted(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .none) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    /// Returns the start of the day for the current date
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    /// Returns the number of days between two dates
    func daysBetween(to otherDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self.startOfDay, to: otherDate.startOfDay)
        return components.day ?? 0
    }
}
