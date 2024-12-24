import Foundation
import Combine

/// Manages the data and logic for the page list view
final class PageListViewModel: ObservableObject {
    @Published var pages: [Page] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadPages()
    }
    
    /// Loads the list of pages
    func loadPages() {
        // Replace with actual data fetching logic
        pages = [
            Page(title: "Page 1"),
            Page(title: "Page 2"),
            Page(title: "Page 3")
        ]
    }
    
    /// Deletes a page
    func deletePage(_ page: Page) {
        pages.removeAll { $0.id == page.id }
    }
}
