import Foundation
import SwiftData

// MARK: - Identifiable Protocol
protocol IdentifiableEntity {
    var id: UUID { get }
}

// MARK: - Repository Protocol
protocol Repository {
    associatedtype Model: IdentifiableEntity
    
    func fetchAll() async -> [Model]
    func fetch(by id: UUID) async -> Model?
    func add(_ model: Model)
    func update(_ model: Model)
    func delete(_ model: Model)
}

// MARK: - API Service Protocol
protocol APIService {
    func fetchData<T: Decodable>(from endpoint: String) async throws -> T
    func postData<T: Encodable, U: Decodable>(to endpoint: String, payload: T) async throws -> U
}

// MARK: - Logger Protocol
protocol LoggerProtocol {
    func log(_ message: String)
    func logError(_ error: Error)
}
