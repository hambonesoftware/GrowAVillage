import Foundation

final class ModuleDetailViewModel: ObservableObject {
    @Published var module: AppModels.Module
    
    init(module: AppModels.Module) {
        self.module = module
    }
    
    func updateName(to newName: String) {
        module.name = newName
    }
}
