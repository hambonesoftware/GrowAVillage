import Foundation

/// Manages the logic for adding a new page
final class AddPageViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    
    /// Creates a new page object
    func createPage() -> Page {
        return Page(title: title)
    }
}
