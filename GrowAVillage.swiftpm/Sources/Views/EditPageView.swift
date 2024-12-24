import SwiftUI

struct EditPageView: View {
    @ObservedObject var viewModel: EditPageViewModel
    
    var body: some View {
        Form {
            TextField("Page Title", text: Binding(
                get: { viewModel.page.title },
                set: { viewModel.updateTitle(to: $0) }
            ))
        }
        .navigationTitle("Edit Page")
    }
}
