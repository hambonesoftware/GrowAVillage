import Foundation

/// Manages the logic for adding a new module
final class AddModuleViewModel: ObservableObject {
    @Published var name: String = ""
    
    /// Creates a new module object
    func createModule() -> Module {
        return Module(name: name)
    }
}
