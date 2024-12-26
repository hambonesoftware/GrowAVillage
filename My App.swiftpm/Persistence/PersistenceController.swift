import SwiftData

final class PersistenceController {
    static let shared = PersistenceController()
    
    let container: ModelContainer
    
    private init() {
        do {
            // Pass models as variadic arguments, not as an array
            container = try ModelContainer(for: 
                                            Component.self, 
                                           DisplayComponent.self, 
                                           InputComponent.self, 
                                           Project.self
            )
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
}
