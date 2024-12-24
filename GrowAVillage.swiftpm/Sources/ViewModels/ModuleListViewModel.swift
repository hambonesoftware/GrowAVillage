import Foundation
import Combine

/// Manages the data and logic for the module list view
final class ModuleListViewModel: ObservableObject {
    @Published var modules: [Module] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadModules()
    }
    
    /// Loads the list of modules
    func loadModules() {
        // Replace with actual data fetching logic
        modules = [
            Module(name: "Module 1"),
            Module(name: "Module 2"),
            Module(name: "Module 3")
        ]
    }
    
    /// Deletes a module
    func deleteModule(_ module: Module) {
        modules.removeAll { $0.id == module.id }
    }
}
