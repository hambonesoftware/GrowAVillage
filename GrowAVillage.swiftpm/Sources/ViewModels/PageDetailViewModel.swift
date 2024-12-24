import Foundation

final class PageDetailViewModel: ObservableObject {
    @Published var page: AppModels.Page
    
    init(page: AppModels.Page) {
        self.page = page
    }
    
    func updateTitle(to newTitle: String) {
        page.title = newTitle
    }
}
