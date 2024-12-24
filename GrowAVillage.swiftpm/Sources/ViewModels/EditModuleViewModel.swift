import Foundation

final class EditModuleViewModel: ObservableObject {
    @Published var module: AppModels.Module
    
    init(module: AppModels.Module) {
        self.module = module
    }
    
    func updateName(to newName: String) {
        module.name = newName
    }
}
