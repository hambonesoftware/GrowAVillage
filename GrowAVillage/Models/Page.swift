import Foundation

struct Page: Identifiable, Codable {
    let id: UUID
    var title: String
    var modules: [Module]
    
    init(id: UUID = UUID(), title: String, modules: [Module]) {
        self.id = id
        self.title = title
        self.modules = modules
        print("Page initialized with id: \(id), title: \(title), modules: \(modules)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, modules
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        modules = try container.decode([Module].self, forKey: .modules)
        print("Page decoded with id: \(id), title: \(title), modules: \(modules)")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(modules, forKey: .modules)
        print("Page encoded with id: \(id), title: \(title), modules: \(modules)")
    }
}
