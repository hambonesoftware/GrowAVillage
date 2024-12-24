import SwiftUI

/// Manages error handling across the application.
final class ErrorManager: ObservableObject {
    static let shared = ErrorManager()
    
    @Published var activeError: AppError? = nil // Tracks the active error for display
    
    private init() {}
    
    /// Handles an error by logging it and optionally reporting it to an external service.
    /// - Parameter error: The `AppError` to handle.
    func handleError(_ error: AppError) {
        // Log the error (use print for Swift Playgrounds, or custom logging if available)
        logError(error)
        
        // Set the error for display in a SwiftUI alert
        DispatchQueue.main.async {
            self.activeError = error
        }
    }
    
    /// Logs the error locally (replaces Logger.shared.logError).
    private func logError(_ error: AppError) {
        print("Error occurred: \(error.localizedDescription)")
    }
}
