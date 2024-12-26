import SwiftUI
import SwiftData

struct DisplayComponentView: View {
    @ObservedObject var displayComponent: DisplayComponent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(displayComponent.name)
                .font(.headline)
            Text("Display Value: \(displayComponent.displayValue)")
            if let dataPoints = displayComponent.dataPoints {
                Text("Data Points: \(dataPoints.map { String($0) }.joined(separator: ", "))")
            }
            if let selectedDate = displayComponent.selectedDate {
                Text("Selected Date: \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
            }
            if let progress = displayComponent.progress {
                ProgressView(value: progress)
            }
        }
        .padding()
        .navigationTitle("Display Component")
    }
}
