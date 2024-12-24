import SwiftUI

/// Form for adding a new page
struct AddPageView: View {
    @State private var title = ""
    @State private var description = ""
    
    var onSave: (Page) -> Void
    
    var body: some View {
        Form {
            Section(header: Text("Page Info")) {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            
            Button("Save") {
                onSave(Page(title: title))
            }
        }
        .navigationTitle("Add Page")
    }
}

struct AddPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddPageView { _ in }
    }
}
