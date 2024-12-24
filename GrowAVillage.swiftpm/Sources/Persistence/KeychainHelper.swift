import Foundation
import Security

/// KeychainHelper provides a simple interface to store, retrieve, and delete data from the Keychain.
final class KeychainHelper {
    // MARK: - Singleton Instance
    
    /// Shared instance of KeychainHelper for global access.
    static let shared = KeychainHelper()
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Save Data
    
    /// Saves data to the Keychain.
    /// - Parameters:
    ///   - data: The data to save.
    ///   - service: A string to identify the service.
    ///   - account: A string to identify the account.
    /// - Returns: True if the operation was successful, false otherwise.
    func save(_ data: Data, service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            let updateQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account
            ]
            
            let attributesToUpdate: [String: Any] = [
                kSecValueData as String: data
            ]
            
            let updateStatus = SecItemUpdate(updateQuery as CFDictionary, attributesToUpdate as CFDictionary)
            return updateStatus == errSecSuccess
        }
        
        return status == errSecSuccess
    }
    
    // MARK: - Read Data
    
    /// Reads data from the Keychain.
    /// - Parameters:
    ///   - service: The service identifier.
    ///   - account: The account identifier.
    /// - Returns: The data if found, otherwise nil.
    func read(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var retrievedData: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &retrievedData)
        
        if status == errSecSuccess {
            return retrievedData as? Data
        } else {
            print("Keychain read failed with status: \(status)")
            return nil
        }
    }
    
    // MARK: - Retrieve Data (Alias for Read)
    
    /// Alias for `read` to provide flexibility in terminology.
    /// - Parameters:
    ///   - service: The service identifier.
    ///   - account: The account identifier.
    /// - Returns: The data if found, otherwise nil.
    func retrieve(service: String, account: String) -> Data? {
        return read(service: service, account: account)
    }
    
    // MARK: - Delete Data
    
    /// Deletes data from the Keychain.
    /// - Parameters:
    ///   - service: The service identifier.
    ///   - account: The account identifier.
    /// - Returns: True if deletion was successful, false otherwise.
    func delete(service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    // MARK: - Convenience Methods for Strings
    
    /// Saves a string to the Keychain.
    /// - Parameters:
    ///   - string: The string to save.
    ///   - service: The service identifier.
    ///   - account: The account identifier.
    /// - Returns: True if the operation was successful, false otherwise.
    func save(_ string: String, service: String, account: String) -> Bool {
        guard let data = string.data(using: .utf8) else {
            print("Failed to convert string to data.")
            return false
        }
        return save(data, service: service, account: account)
    }
    
    /// Reads a string from the Keychain.
    /// - Parameters:
    ///   - service: The service identifier.
    ///   - account: The account identifier.
    /// - Returns: The string if found, otherwise nil.
    func readString(service: String, account: String) -> String? {
        guard let data = read(service: service, account: account) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    /// Deletes a string from the Keychain.
    /// - Parameters:
    ///   - service: The service identifier.
    ///   - account: The account identifier.
    /// - Returns: True if deletion was successful, false otherwise.
    func deleteString(service: String, account: String) -> Bool {
        return delete(service: service, account: account)
    }
}
