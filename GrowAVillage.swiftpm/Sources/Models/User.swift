import Foundation
import SwiftData

@Model
final class User: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    var createdAt: Date
    
    // Additional user preferences can be added here
    var preferredLanguage: String
    
    init(id: UUID = UUID(), name: String, email: String, preferredLanguage: String = "en") {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = Date()
        self.preferredLanguage = preferredLanguage
    }
}
