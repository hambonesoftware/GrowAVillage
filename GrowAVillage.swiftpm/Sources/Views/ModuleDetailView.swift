import SwiftUI

/// Displays details of a single module
struct ModuleDetailView: View {
    let module: Module // Replace with your actual module model
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(module.name)
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Module Details Here") // Replace with actual details
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Module Details")
    }
}

struct ModuleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDetailView(module: Module(name: "Sample Module"))
    }
}
