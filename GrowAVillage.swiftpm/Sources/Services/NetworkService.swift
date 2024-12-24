import Foundation
import Combine

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case responseError(statusCode: Int)
    case decodingError
    case encodingError
    case unknown
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .responseError(let statusCode):
            return "Received HTTP status code \(statusCode)."
        case .decodingError:
            return "Failed to decode the response."
        case .encodingError:
            return "Failed to encode the request."
        case .unknown:
            return "An unknown error occurred."
        case .noData:
            return "No data was received from the server."
        }
    }
}

final class NetworkService {
    static let shared = NetworkService()
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    
    private init(urlSession: URLSession = .shared,
                 jsonDecoder: JSONDecoder = JSONDecoder(),
                 jsonEncoder: JSONEncoder = JSONEncoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }
    
    /// Performs a GET request to the specified endpoint.
    /// - Parameters:
    ///   - endpoint: The API endpoint path.
    ///   - queryParameters: Optional query parameters.
    /// - Returns: A publisher emitting the decoded response or a `NetworkError`.
    func get<T: Decodable>(endpoint: String,
                           queryParameters: [String: String]? = nil) -> AnyPublisher<T, NetworkError> {
        guard var components = URLComponents(string: Config.shared.apiBaseURL + endpoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        if let queryParameters = queryParameters {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(getAuthToken())", forHTTPHeaderField: "Authorization")
        
        Logger.shared.log("GET Request: \(url.absoluteString)")
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { [weak self] result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError(statusCode: httpResponse.statusCode)
                }
                
                guard !result.data.isEmpty else {
                    throw NetworkError.noData
                }
                
                return result.data
            }
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if error is DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// Performs a POST request to the specified endpoint with the given payload.
    /// - Parameters:
    ///   - endpoint: The API endpoint path.
    ///   - payload: The data to send in the request body.
    /// - Returns: A publisher emitting the decoded response or a `NetworkError`.
    func post<T: Decodable, U: Encodable>(endpoint: String,
                                          payload: U) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: Config.shared.apiBaseURL + endpoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(getAuthToken())", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try jsonEncoder.encode(payload)
        } catch {
            return Fail(error: NetworkError.encodingError).eraseToAnyPublisher()
        }
        
        Logger.shared.log("POST Request: \(url.absoluteString)")
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { [weak self] result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError(statusCode: httpResponse.statusCode)
                }
                
                guard !result.data.isEmpty else {
                    throw NetworkError.noData
                }
                
                return result.data
            }
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if error is DecodingError {
                    return NetworkError.decodingError
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// Retrieves the authentication token from storage.
    /// - Returns: The authentication token as a `String`.
    private func getAuthToken() -> String {
        // Retrieve the token from Keychain or UserDefaults
        // For example:
        if let tokenData = KeychainHelper.shared.retrieve(service: "YourAppService", account: "authToken"),
           let token = String(data: tokenData, encoding: .utf8) {
            return token
        }
        return ""
    }
    
    /// Example method to handle dynamic endpoint paths with parameters.
    /// - Parameters:
    ///   - endpoint: The API endpoint path with placeholders.
    ///   - parameters: Dictionary of parameters to replace in the endpoint.
    /// - Returns: The final endpoint path with parameters replaced.
    func buildEndpoint(_ endpoint: String, with parameters: [String: String]) -> String {
        var finalEndpoint = endpoint
        for (key, value) in parameters {
            finalEndpoint = finalEndpoint.replacingOccurrences(of: "{\(key)}", with: value)
        }
        return finalEndpoint
    }
}
