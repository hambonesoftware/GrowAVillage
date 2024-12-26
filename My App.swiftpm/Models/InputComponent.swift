import SwiftData
import Foundation

@Model
final class InputComponent: ObservableObject, Identifiable {
    @Attribute(.unique) var uniqueID: UUID = UUID()
    var id: UUID { uniqueID }
    
    @Attribute var name: String = ""
    @Attribute var currentValue: String = ""
    @Attribute var placeholder: String = ""
    @Attribute var minValue: Double?
    @Attribute var maxValue: Double?
    @Attribute var step: Double?
    @Attribute var numberValue: Int?
    
    @Relationship(deleteRule: .cascade) var project: Project?
    
    // Initializer
    init(
        uniqueID: UUID = UUID(),
        name: String = "",
        currentValue: String = "",
        placeholder: String = "",
        minValue: Double? = nil,
        maxValue: Double? = nil,
        step: Double? = nil,
        numberValue: Int? = nil,
        project: Project? = nil
    ) {
        self.uniqueID = uniqueID
        self.name = name
        self.currentValue = currentValue
        self.placeholder = placeholder
        self.minValue = minValue
        self.maxValue = maxValue
        self.step = step
        self.numberValue = numberValue
        self.project = project
    }
}
