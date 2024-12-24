import SwiftUI

struct EditModuleView: View {
    @ObservedObject var viewModel: EditModuleViewModel
    
    var body: some View {
        Form {
            TextField("Module Name", text: Binding(
                get: { viewModel.module.name },
                set: { viewModel.updateName(to: $0) }
            ))
        }
        .navigationTitle("Edit Module")
    }
}
