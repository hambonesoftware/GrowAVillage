import Foundation

final class PersistenceHelper {
    static let shared = PersistenceHelper()
    private init() {}
    
    /// Saves data to the specified filename in the app's documents directory.
    /// - Parameters:
    ///   - data: The data to save.
    ///   - filename: The name of the file.
    /// - Throws: An error if the save operation fails.
    func saveData(_ data: Data, to filename: String) throws {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
    }
    
    /// Retrieves data from the specified filename in the app's documents directory.
    /// - Parameter filename: The name of the file.
    /// - Returns: The retrieved data.
    /// - Throws: An error if the retrieval operation fails.
    func retrieveData(from filename: String) throws -> Data {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return try Data(contentsOf: url)
    }
    
    /// Deletes data from the specified filename in the app's documents directory.
    /// - Parameter filename: The name of the file.
    /// - Throws: An error if the deletion operation fails.
    func deleteData(from filename: String) throws {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        try FileManager.default.removeItem(at: url)
    }
    
    /// Checks if a file exists in the app's documents directory.
    /// - Parameter filename: The name of the file.
    /// - Returns: `true` if the file exists, `false` otherwise.
    func fileExists(_ filename: String) -> Bool {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    /// Returns the app's documents directory URL.
    /// - Returns: The documents directory URL.
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
