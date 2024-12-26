// Page.swift
import SwiftData
import Foundation

@Model
final class Page: Identifiable {
    @Attribute(.unique) var uniqueID: UUID = UUID()
    var id: UUID { uniqueID }
    
    @Attribute var title: String = "Untitled Page"
    
    // Optional custom initializer
    init(uniqueID: UUID = UUID(), title: String = "Untitled Page") {
        self.uniqueID = uniqueID
        self.title = title
    }
}
