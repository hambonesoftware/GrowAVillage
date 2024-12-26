import SwiftUI
import SwiftData

struct ComponentListView: View {
    @Query var components: [Component]
    
    var body: some View {
        List(components) { component in
            NavigationLink(destination: {
                if let displayComponent = component as? DisplayComponent {
                    DisplayComponentView(displayComponent: displayComponent)
                } else if let inputComponent = component as? InputComponent {
                    InputComponentView(inputComponent: inputComponent)
                } else {
                    Text("Unknown Component Type")
                }
            }) {
                Text(component.name)
            }
        }
        .navigationTitle("Components")
    }
}
