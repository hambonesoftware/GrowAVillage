import Foundation

struct DataValidator {
    
    /// Validates if the provided email string is in a valid format.
    /// - Parameter email: The email string to validate.
    /// - Returns: `true` if valid, `false` otherwise.
    static func isValidEmail(_ email: String) -> Bool {
        // Simple regex for email validation
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /// Validates if the provided password meets the required criteria.
    /// - Parameter password: The password string to validate.
    /// - Returns: `true` if valid, `false` otherwise.
    static func isValidPassword(_ password: String) -> Bool {
        // Example: At least 8 characters, one uppercase, one lowercase, one number
        let passwordRegEx = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"#
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    /// Validates if the provided username meets the required criteria.
    /// - Parameter username: The username string to validate.
    /// - Returns: `true` if valid, `false` otherwise.
    static func isValidUsername(_ username: String) -> Bool {
        // Example: 3-20 characters, alphanumeric and underscores
        let usernameRegEx = #"^[A-Za-z0-9_]{3,20}$"#
        let usernamePred = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: username)
    }
    
    // Add more validation functions as needed
}
