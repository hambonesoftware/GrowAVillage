import Foundation

/// Manages analytics tracking throughout the application.
final class AnalyticsService {
    // MARK: - Singleton
    static let shared = AnalyticsService()
    
    // MARK: - Initializer
    private init() {}
    
    // MARK: - Event Tracking
    
    /// Tracks a generic event with optional parameters.
    /// - Parameters:
    ///   - name: The name of the event.
    ///   - parameters: Additional parameters associated with the event.
    private func trackEvent(name: String, parameters: [String: Any]? = nil) {
        // Placeholder for actual analytics tracking logic
        print("Tracked Event: \(name) with parameters: \(parameters ?? [:])")
    }
    
    // MARK: - Specific Event Tracking
    
    /// Tracks when a user adds a page.
    /// - Parameter page: The `AppModels.Page` that was added.
    func trackPageAddition(page: AppModels.Page) {
        trackEvent(name: "AddPage", parameters: [
            "page_id": page.id.uuidString,
            "page_title": page.title
        ])
    }
    
    /// Tracks when a user adds a module.
    /// - Parameter module: The `AppModels.Module` that was added.
    func trackModuleAddition(module: AppModels.Module) {
        trackEvent(name: "AddModule", parameters: [
            "module_id": module.id.uuidString,
            "module_name": module.name
        ])
    }
    
    /// Tracks when a user views a page.
    /// - Parameter page: The `AppModels.Page` that was viewed.
    func trackPageView(page: AppModels.Page) {
        trackEvent(name: "ViewPage", parameters: [
            "page_id": page.id.uuidString,
            "page_title": page.title
        ])
    }
    
    /// Tracks when a user deletes a page.
    /// - Parameter page: The `AppModels.Page` that was deleted.
    func trackPageDeletion(page: AppModels.Page) {
        trackEvent(name: "DeletePage", parameters: [
            "page_id": page.id.uuidString,
            "page_title": page.title
        ])
    }
    
    /// Tracks when a user deletes a module.
    /// - Parameter module: The `AppModels.Module` that was deleted.
    func trackModuleDeletion(module: AppModels.Module) {
        trackEvent(name: "DeleteModule", parameters: [
            "module_id": module.id.uuidString,
            "module_name": module.name
        ])
    }
    
    // MARK: - Initialization Tracking
    
    /// Initializes the analytics service. Call this during app launch.
    func initialize() {
        print("AnalyticsService initialized.")
    }
}
