import Foundation
import Combine

/// Handles the main dashboard logic
final class ContentViewModel: ObservableObject {
    @Published var pages: [Page] = []
    @Published var modules: [Module] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadPages()
        loadModules()
    }
    
    /// Loads pages from a data source (mocked here)
    func loadPages() {
        // Replace with actual data fetching logic
        pages = [
            Page(title: "Page 1"),
            Page(title: "Page 2")
        ]
    }
    
    /// Loads modules from a data source (mocked here)
    func loadModules() {
        // Replace with actual data fetching logic
        modules = [
            Module(name: "Module 1"),
            Module(name: "Module 2")
        ]
    }
}
