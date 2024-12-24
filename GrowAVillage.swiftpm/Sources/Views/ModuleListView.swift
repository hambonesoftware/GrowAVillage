import SwiftUI

/// Displays a list of modules
struct ModuleListView: View {
    let modules: [Module] // Replace with your actual module model
    let onModuleSelected: (Module) -> Void
    let onDeleteModule: (Module) -> Void
    
    var body: some View {
        List {
            ForEach(modules) { module in
                HStack {
                    Text(module.name) // Replace with your actual module name property
                        .font(.headline)
                    Spacer()
                    Button(action: { onDeleteModule(module) }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    onModuleSelected(module)
                }
            }
        }
        .navigationTitle("Modules")
    }
}

/// Mock model for `Module`
struct Module: Identifiable {
    let id = UUID()
    let name: String
}

struct ModuleListView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListView(
            modules: [Module(name: "Module 1"), Module(name: "Module 2")],
            onModuleSelected: { _ in },
            onDeleteModule: { _ in }
        )
    }
}
