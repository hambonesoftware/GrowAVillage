import Foundation

/// Represents errors that can occur within the application.
enum AppError: Error, LocalizedError {
    case networkError(NetworkError)
    case databaseError(DatabaseError)
    case invalidInput(description: String)
    case unauthorized
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkError(let networkError):
            return networkError.localizedDescription
        case .databaseError(let databaseError):
            return databaseError.localizedDescription
        case .invalidInput(let description):
            return description
        case .unauthorized:
            return "You are not authorized to perform this action."
        case .unknown:
            return "An unknown error occurred. Please try again later."
        }
    }
}

/// Represents database-related errors.
enum DatabaseError: Error, LocalizedError {
    case saveFailed
    case fetchFailed
    case deleteFailed
    case entityNotFound
    
    var errorDescription: String? {
        switch self {
        case .saveFailed:
            return "Failed to save data to the database."
        case .fetchFailed:
            return "Failed to fetch data from the database."
        case .deleteFailed:
            return "Failed to delete data from the database."
        case .entityNotFound:
            return "The requested data could not be found."
        }
    }
}
