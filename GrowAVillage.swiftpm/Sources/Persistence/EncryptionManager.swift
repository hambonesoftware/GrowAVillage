import Foundation
import CryptoKit

/// Handles encryption and decryption of data using CryptoKit's AES-GCM.
final class EncryptionManager {
    // MARK: - Singleton Instance
    static let shared = EncryptionManager()
    
    // MARK: - Properties
    private let keyIdentifier = "com.yourapp.encryptionkey"
    private var symmetricKey: SymmetricKey?
    
    // MARK: - Initializer
    private init() {
        // Attempt to retrieve the key from Keychain.
        if let keyData = KeychainHelper.shared.read(service: keyIdentifier, account: "default") {
            symmetricKey = SymmetricKey(data: keyData)
            print("Encryption key retrieved from Keychain.")
        } else {
            // Generate a new symmetric key if not found.
            generateNewKey()
        }
    }
    
    // MARK: - Encryption
    /// Encrypts the given data using AES-GCM.
    /// - Parameter plaintext: The data to encrypt.
    /// - Returns: Encrypted data (ciphertext) if successful, otherwise nil.
    func encrypt(plaintext: Data) -> Data? {
        guard let key = symmetricKey else {
            print("Symmetric key not available for encryption.")
            return nil
        }
        
        do {
            let sealedBox = try AES.GCM.seal(plaintext, using: key)
            let nonceBytes = sealedBox.nonce.withUnsafeBytes { Data($0) }
            let combined = nonceBytes + sealedBox.ciphertext + sealedBox.tag
            return combined
        } catch {
            print("Encryption failed with error: \(error)")
            return nil
        }
    }
    
    // MARK: - Decryption
    /// Decrypts the given data using AES-GCM.
    /// - Parameter ciphertext: The encrypted data to decrypt.
    /// - Returns: Decrypted data (plaintext) if successful, otherwise nil.
    func decrypt(ciphertext: Data) -> Data? {
        guard let key = symmetricKey else {
            print("Symmetric key not available for decryption.")
            return nil
        }
        
        let nonceSize = 12
        let tagSize = 16
        
        guard ciphertext.count > nonceSize + tagSize else {
            print("Ciphertext is too short to contain nonce and tag.")
            return nil
        }
        
        let nonceData = ciphertext.prefix(nonceSize)
        let tagData = ciphertext.suffix(tagSize)
        let cipherData = ciphertext.dropFirst(nonceSize).dropLast(tagSize)
        
        do {
            let nonce = try AES.GCM.Nonce(data: nonceData)
            let sealedBox = try AES.GCM.SealedBox(nonce: nonce, ciphertext: cipherData, tag: tagData)
            return try AES.GCM.open(sealedBox, using: key)
        } catch {
            print("Decryption failed with error: \(error)")
            return nil
        }
    }
    
    // MARK: - Key Management
    /// Generates a new symmetric key and stores it in Keychain.
    func generateNewKey() {
        let newKey = SymmetricKey(size: .bits256)
        let keyData = newKey.withUnsafeBytes { Data($0) }
        if KeychainHelper.shared.save(keyData, service: keyIdentifier, account: "default") {
            symmetricKey = newKey
            print("New encryption key generated and saved to Keychain.")
        } else {
            fatalError("Failed to save encryption key to Keychain.")
        }
    }
    
    /// Deletes the symmetric key from Keychain.
    func deleteKey() {
        if KeychainHelper.shared.delete(service: keyIdentifier, account: "default") {
            symmetricKey = nil
            print("Encryption key deleted from Keychain.")
        }
    }
}
