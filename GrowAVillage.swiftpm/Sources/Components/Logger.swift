import Foundation

/// A simple logger for debugging and error tracking.
final class Logger {
    static let shared = Logger() // Singleton instance
    
    private init() {} // Prevent external instantiation
    
    /// Logs a message.
    /// - Parameter message: The message to log.
    func log(_ message: String) {
        print("[LOG]: \(message)")
    }
    
    /// Logs an error.
    /// - Parameter error: The error to log.
    func logError(_ error: Error) {
        print("[ERROR]: \(error.localizedDescription)")
    }
}
