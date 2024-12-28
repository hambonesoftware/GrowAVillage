import Foundation

enum ComponentType: String, Codable {
    case text
    case number
    case date
    case toggle
    case picker
}

struct AnyCodable: Codable {
    var value: Any
    
    init(_ value: Any) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        } else if let boolValue = try? container.decode(Bool.self) {
            value = boolValue
        } else if let dateValue = try? container.decode(Date.self) {
            value = dateValue
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported type")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let intValue = value as? Int {
            try container.encode(intValue)
        } else if let doubleValue = value as? Double {
            try container.encode(doubleValue)
        } else if let stringValue = value as? String {
            try container.encode(stringValue)
        } else if let boolValue = value as? Bool {
            try container.encode(boolValue)
        } else if let dateValue = value as? Date {
            try container.encode(dateValue)
        } else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: container.codingPath, debugDescription: "Unsupported type"))
        }
    }
}

struct Component: Identifiable, Codable {
    let id: UUID
    let type: ComponentType
    let title: String
    var value: AnyCodable
    
    init(id: UUID = UUID(), type: ComponentType, title: String, value: AnyCodable) {
        self.id = id
        self.type = type
        self.title = title
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case id, type, title, value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        type = try container.decode(ComponentType.self, forKey: .type)
        title = try container.decode(String.self, forKey: .title)
        value = try container.decode(AnyCodable.self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(title, forKey: .title)
        try container.encode(value, forKey: .value)
    }
}
