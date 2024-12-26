import Foundation

extension UUID {
    /// Generates a random UUID as a string
    static func randomString() -> String {
        UUID().uuidString
    }
}
