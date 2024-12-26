import SwiftData
import Foundation

@Model
final class DisplayComponent: ObservableObject, Identifiable {
    @Attribute(.unique) var uniqueID: UUID = UUID()
    var id: UUID { uniqueID }
    
    @Attribute var name: String = ""
    @Attribute var displayValue: String = ""
    @Attribute var dataPoints: [Double]?
    @Attribute var selectedDate: Date?
    @Attribute var progress: Double?
    
    @Relationship(deleteRule: .cascade) var project: Project?
    
    // Initializer
    init(
        uniqueID: UUID = UUID(),
        name: String = "",
        displayValue: String = "",
        dataPoints: [Double]? = nil,
        selectedDate: Date? = nil,
        progress: Double? = nil,
        project: Project? = nil
    ) {
        self.uniqueID = uniqueID
        self.name = name
        self.displayValue = displayValue
        self.dataPoints = dataPoints
        self.selectedDate = selectedDate
        self.progress = progress
        self.project = project
    }
}
