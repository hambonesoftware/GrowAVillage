import SwiftUI

/// Form for adding a new module
struct AddModuleView: View {
    @State private var name = ""
    
    var onSave: (Module) -> Void
    
    var body: some View {
        Form {
            Section(header: Text("Module Info")) {
                TextField("Name", text: $name)
            }
            
            Button("Save") {
                onSave(Module(name: name))
            }
        }
        .navigationTitle("Add Module")
    }
}

struct AddModuleView_Previews: PreviewProvider {
    static var previews: some View {
        AddModuleView { _ in }
    }
}
