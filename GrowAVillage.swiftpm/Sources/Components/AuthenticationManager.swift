import Foundation

/// Authentication response model
struct AuthResponse: Decodable {
    let token: String
    let user: AuthenticatedUser
}

/// Authenticated user model
struct AuthenticatedUser: Decodable {
    let id: String
    let name: String
    let email: String
}

/// Manages user authentication
final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init() {}
    
    /// Authenticates a user with provided credentials
    /// - Parameters:
    ///   - email: User's email
    ///   - password: User's password
    ///   - completion: Completion handler with success or error
    func authenticate(
        email: String,
        password: String,
        completion: @escaping (Result<AuthResponse, AuthError>) -> Void
    ) {
        let url = URL(string: "https://api.example.com/authenticate")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["email": email, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                completion(.success(authResponse))
            } catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }.resume()
    }
}

/// Authentication errors
enum AuthError: Error {
    case networkError(String)
    case invalidResponse
    case decodingError(String)
}
