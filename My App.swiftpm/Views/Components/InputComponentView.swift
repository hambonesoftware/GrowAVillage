import SwiftUI
import SwiftData

struct InputComponentView: View {
    @ObservedObject var inputComponent: InputComponent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(inputComponent.name)
                .font(.headline)
            Text("Current Value: \(inputComponent.currentValue)")
            Text("Placeholder: \(inputComponent.placeholder)")
            if let minValue = inputComponent.minValue, let maxValue = inputComponent.maxValue {
                Text("Value Range: \(minValue) - \(maxValue)")
            }
            if let step = inputComponent.step {
                Text("Step: \(step)")
            }
            if let numberValue = inputComponent.numberValue {
                Text("Number Value: \(numberValue)")
            }
        }
        .padding()
        .navigationTitle("Input Component")
    }
}
