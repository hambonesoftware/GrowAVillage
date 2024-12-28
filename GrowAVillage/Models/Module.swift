import Foundation

struct Module: Identifiable, Codable {
    let id: UUID
    let title: String
    var components: [Component]
    
    init(id: UUID = UUID(), title: String, components: [Component]) {
        self.id = id
        self.title = title
        self.components = components
        print("Module initialized with id: \(id), title: \(title), components: \(components)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, components
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        components = try container.decode([Component].self, forKey: .components)
        print("Module decoded with id: \(id), title: \(title), components: \(components)")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(components, forKey: .components)
        print("Module encoded with id: \(id), title: \(title), components: \(components)")
    }
}
