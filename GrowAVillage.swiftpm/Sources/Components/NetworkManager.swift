import Foundation

/// Handles all network-related operations
final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Makes a network request with modern Swift concurrency
    /// - Parameters:
    ///   - url: The URL to request
    ///   - method: The HTTP method to use (GET, POST, etc.)
    ///   - body: The optional request body as `Encodable`
    ///   - headers: Optional HTTP headers
    /// - Returns: The `Data` object from the response
    func request<T: Encodable>(
        url: URL,
        method: String = "GET",
        body: T? = nil,
        headers: [String: String]? = nil
    ) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add headers if provided
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Encode the request body if provided
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        // Perform the network request
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Validate the response
            try validateResponse(response)
            
            return data
        } catch {
            throw error
        }
    }
    
    /// Decodes a response from the network request
    /// - Parameters:
    ///   - type: The expected response type conforming to `Decodable`
    ///   - url: The URL to request
    ///   - method: The HTTP method
    ///   - body: The optional request body as `Encodable`
    ///   - headers: Optional HTTP headers
    /// - Returns: A decoded response object of the specified type
    func requestDecoded<T: Decodable, U: Encodable>(
        type: T.Type,
        url: URL,
        method: String = "GET",
        body: U? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        let data = try await request(url: url, method: method, body: body, headers: headers)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NSError(domain: "NetworkManager", code: 3, userInfo: [
                NSLocalizedDescriptionKey: "Failed to decode the response."
            ])
        }
    }
    
    /// Validates the HTTP response
    /// - Parameter response: The URL response to validate
    /// - Throws: An error if the response is invalid
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "NetworkManager", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid response from the server."
            ])
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "NetworkManager", code: 2, userInfo: [
                NSLocalizedDescriptionKey: "Server responded with status code \(httpResponse.statusCode)."
            ])
        }
    }
}
