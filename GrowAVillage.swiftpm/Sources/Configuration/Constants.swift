import Foundation
import SwiftUI

struct Constants {
    // MARK: - API Endpoints
    struct API {
        static let baseURL = "https://api.yourapp.com"
        static let signIn = "/auth/signin"
        static let signUp = "/auth/signup"
        static let fetchPages = "/pages"
        static let addPage = "/pages"
        static let updatePage = "/pages/{page_id}"
        static let deletePage = "/pages/{page_id}"
        static let addModule = "/pages/{page_id}/modules"
        static let updateModule = "/pages/{page_id}/modules/{module_id}"
        static let deleteModule = "/pages/{page_id}/modules/{module_id}"
        // Add more endpoints as needed
    }
    
    // MARK: - Default Values
    struct Defaults {
        static let defaultPageTitle = "New Page"
        static let defaultPageDescription = "Enter page description here."
        static let defaultModuleTitle = "New Module"
        static let defaultModuleDescription = "Enter module description here."
        static let defaultProgress = 0.0
        // Add more defaults as needed
    }
    
    // MARK: - UserDefaults Keys
    struct UserDefaultsKeys {
        static let authToken = "authToken"
        static let userID = "userID"
        // Add more keys as needed
    }
    
    // MARK: - Keychain Keys
    struct KeychainKeys {
        static let encryptionKey = "encryptionKey"
        static let refreshToken = "refreshToken"
        // Add more keys as needed
    }
    
    // MARK: - UI Constants
    struct UI {
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 16
        static let animationDuration: Double = 0.3
        static let buttonHeight: CGFloat = 44
        static let shadowRadius: CGFloat = 5
        // Add more UI constants as needed
    }
    
    // MARK: - Notifications
    struct Notifications {
        static let didSignIn = Notification.Name("didSignIn")
        static let didSignOut = Notification.Name("didSignOut")
        
        // Newly added notifications for pages and modules
        static let didAddPage = Notification.Name("didAddPage")
        static let didDeletePage = Notification.Name("didDeletePage")
        static let didUpdatePage = Notification.Name("didUpdatePage")
        static let didAddModule = Notification.Name("didAddModule")
        static let didDeleteModule = Notification.Name("didDeleteModule")
        static let didUpdateModule = Notification.Name("didUpdateModule")
    }
    
    // MARK: - Localization
    struct Localization {
        static let greetingKey = "greeting"
        static let errorInvalidInputKey = "error_invalid_input"
        // Add more localization keys as needed
    }
    
    // MARK: - Analytics
    struct Analytics {
        static let eventSignIn = "sign_in"
        static let eventSignUp = "sign_up"
        static let eventAddPage = "add_page"
        static let eventAddModule = "add_module"
        // Add more analytics event names as needed
    }
    
    // MARK: - Security
    struct Security {
        static let encryptionAlgorithm = "AES256"
        static let encryptionKeySize = 256
        // Add more security-related constants as needed
    }
}
