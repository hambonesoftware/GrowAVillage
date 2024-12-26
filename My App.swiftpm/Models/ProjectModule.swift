// ProjectModule.swift
import SwiftData
import Foundation

@Model
final class ProjectModule: Identifiable {
    @Attribute(.unique) var uniqueID: UUID = UUID()
    var id: UUID { uniqueID }
    
    @Attribute var name: String = "Untitled Module"
    
    // Link to a Page by storing a UUID
    @Attribute var associatedPageID: UUID?
    
    init(
        uniqueID: UUID = UUID(),
        name: String = "Untitled Module",
        associatedPageID: UUID? = nil
    ) {
        self.uniqueID = uniqueID
        self.name = name
        self.associatedPageID = associatedPageID
    }
}
