import Foundation
import SwiftUI
import SwiftData

/// Manages data storage and retrieval for pages and modules.
@MainActor
final class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var pages: [AppModels.Page] = []
    @Published var modules: [AppModels.Module] = []
    
    private let context: ModelContext
    
    private init() {
        context = PersistentContainer.shared.container.mainContext
    }
    
    // MARK: - Fetching Data
    func loadPages() {
        do {
            let fetchDescriptor = FetchDescriptor<AppModels.Page>()
            pages = try context.fetch(fetchDescriptor)
            print("Pages loaded successfully.")
        } catch {
            print("Failed to load pages: \(error)")
        }
    }
    
    func loadModules(for page: AppModels.Page) {
        do {
            let predicate = #Predicate<AppModels.Module> { $0.associatedPageID == page.id }
            let fetchDescriptor = FetchDescriptor<AppModels.Module>(predicate: predicate)
            modules = try context.fetch(fetchDescriptor)
            print("Modules loaded successfully for page \(page.title).")
        } catch {
            print("Failed to load modules: \(error)")
        }
    }
    
    // MARK: - CRUD Operations
    func addPage(title: String) {
        let page = AppModels.Page(title: title)
        context.insert(page)
        saveContext()
    }
    
    func deletePage(_ page: AppModels.Page) {
        context.delete(page)
        saveContext()
    }
    
    func updatePage(_ page: AppModels.Page, withTitle title: String) {
        page.title = title
        saveContext()
    }
    
    func addModule(name: String, toPage page: AppModels.Page) {
        let module = AppModels.Module(name: name, associatedPageID: page.id)
        context.insert(module)
        saveContext()
    }
    
    func deleteModule(_ module: AppModels.Module) {
        context.delete(module)
        saveContext()
    }
    
    func updateModule(_ module: AppModels.Module, withName name: String) {
        module.name = name
        saveContext()
    }
    
    // MARK: - Save Context
    private func saveContext() {
        do {
            try context.save()
            print("Context saved successfully.")
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
