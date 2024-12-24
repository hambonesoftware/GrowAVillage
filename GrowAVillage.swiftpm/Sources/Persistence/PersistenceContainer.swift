import Foundation
import SwiftData

/// Manages the SwiftData container for the application.
final class PersistentContainer {
    // MARK: - Singleton Instance
    static let shared = PersistentContainer()
    
    // MARK: - Properties
    public let container: ModelContainer
    
    // MARK: - Initializer
    private init() {
        do {
            // Initialize the ModelContainer with the model types
            container = try ModelContainer(for: AppModels.Page.self, AppModels.Module.self)
            print("PersistentContainer successfully initialized.")
        } catch {
            fatalError("Failed to initialize PersistentContainer: \(error)")
        }
    }
    
    // MARK: - Save Context
    @MainActor
    public func saveContext() {
        do {
            try container.mainContext.save()
            print("Context saved successfully.")
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
