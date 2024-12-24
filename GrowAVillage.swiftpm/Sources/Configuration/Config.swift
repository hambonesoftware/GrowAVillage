import Foundation

struct Config {
    static let shared = Config()
    
    let environment: Environment
    let apiKey: String
    let enableAnalytics: Bool
    let enableDebugLogs: Bool
    
    private init() {
#if DEBUG
        self.environment = .development
        self.apiKey = "DEV_API_KEY_123456"
        self.enableAnalytics = false
        self.enableDebugLogs = true
#elseif STAGING
        self.environment = .staging
        self.apiKey = "STAGING_API_KEY_123456"
        self.enableAnalytics = true
        self.enableDebugLogs = false
#else
        self.environment = .production
        self.apiKey = "PROD_API_KEY_123456"
        self.enableAnalytics = true
        self.enableDebugLogs = false
#endif
    }
    
    enum Environment: String {
        case development = "Development"
        case staging = "Staging"
        case production = "Production"
    }
    
    /// Returns the full API base URL based on the current environment.
    var apiBaseURL: String {
        switch environment {
        case .development:
            return "https://dev-api.yourapp.com"
        case .staging:
            return "https://staging-api.yourapp.com"
        case .production:
            return Constants.API.baseURL
        }
    }
    
    /// Determines if the app should display debug logs.
    var shouldDisplayDebugLogs: Bool {
        return enableDebugLogs
    }
    
    /// Determines if analytics should be enabled.
    var isAnalyticsEnabled: Bool {
        return enableAnalytics
    }
    
    /// Provides the API key for network requests.
    var currentAPIKey: String {
        return apiKey
    }
    
    // Add more configuration properties as needed
}
