import Foundation
import SwiftData

/// Manages SwiftData operations for the application.
@MainActor
final class DatabaseService {
    static let shared = DatabaseService()
    
    private let container: ModelContainer
    private let context: ModelContext
    
    private init() {
        do {
            // Initialize the ModelContainer with your models
            container = try ModelContainer(for: AppModels.Page.self, AppModels.Module.self)
            context = container.mainContext
            print("SwiftData ModelContainer successfully initialized.")
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error)")
        }
    }
    
    /// Fetches all objects of a specific model type.
    func fetchAll<T: PersistentModel>(modelType: T.Type) -> [T] {
        do {
            let fetchDescriptor = FetchDescriptor<T>()
            return try context.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch objects: \(error)")
            return []
        }
    }
    
    /// Fetches a single object by ID.
    func fetchByID<T: PersistentModel>(modelType: T.Type, id: UUID) -> T? {
        do {
            // Cast id to UUID for comparison
            let fetchDescriptor = FetchDescriptor<T>(predicate: #Predicate { ($0.id as? UUID) == id })
            return try context.fetch(fetchDescriptor).first
        } catch {
            print("Failed to fetch object by ID: \(error)")
            return nil
        }
    }
    
    /// Adds a new object to the context.
    func addObject<T: PersistentModel>(_ object: T) {
        context.insert(object)
        saveContext()
    }
    
    /// Deletes an object from the context.
    func deleteObject<T: PersistentModel>(_ object: T) {
        context.delete(object)
        saveContext()
    }
    
    /// Saves the current context.
    private func saveContext() {
        do {
            try context.save()
            print("Context saved successfully.")
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
