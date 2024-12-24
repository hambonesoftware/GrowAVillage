import Foundation

/// A type-erased `Codable` value.
struct AnyCodable: Codable {
    let value: Any
    
    init(_ value: Any) {
        self.value = value
    }
    
    // Encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch value {
        case let number as NSNumber:
            try encodeNSNumber(number, to: &container)
        case let string as String:
            try container.encode(string)
        case let bool as Bool:
            try container.encode(bool)
        case let array as [Any]:
            let anyCodableArray = array.map { AnyCodable($0) }
            try container.encode(anyCodableArray)
        case let dictionary as [String: Any]:
            let anyCodableDict = dictionary.mapValues { AnyCodable($0) }
            try container.encode(anyCodableDict)
        case is NSNull:
            try container.encodeNil()
        default:
            let context = EncodingError.Context(codingPath: container.codingPath,
                                                debugDescription: "AnyCodable value cannot be encoded")
            throw EncodingError.invalidValue(value, context)
        }
    }
    
    private func encodeNSNumber(_ number: NSNumber, to container: inout SingleValueEncodingContainer) throws {
        switch CFNumberGetType(number) {
        case .charType:
            try container.encode(number.boolValue)
        case .shortType, .intType, .longType, .longLongType, .cfIndexType, .nsIntegerType:
            try container.encode(number.intValue)
        case .floatType, .doubleType, .float32Type, .float64Type, .cgFloatType:
            try container.encode(number.doubleValue)
        @unknown default:
            let context = EncodingError.Context(codingPath: container.codingPath,
                                                debugDescription: "NSNumber value cannot be encoded")
            throw EncodingError.invalidValue(number, context)
        }
    }
    
    // Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self.init(NSNull())
        } else if let bool = try? container.decode(Bool.self) {
            self.init(bool)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else if let double = try? container.decode(Double.self) {
            self.init(double)
        } else if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let array = try? container.decode([AnyCodable].self) {
            self.init(array.map { $0.value })
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            let dict = dictionary.mapValues { $0.value }
            self.init(dict)
        } else {
            let context = DecodingError.Context(codingPath: container.codingPath,
                                                debugDescription: "AnyCodable value cannot be decoded")
            throw DecodingError.typeMismatch(AnyCodable.self, context)
        }
    }
}

extension AnyCodable: Equatable {
    static func == (lhs: AnyCodable, rhs: AnyCodable) -> Bool {
        // Implement a suitable equality check if needed
        return false
    }
}
