import Foundation

/// LoggingManager handles centralized logging for the application,
/// capturing actions, errors, and debugging information.
final class LoggingManager {
    // MARK: - Singleton Instance
    
    /// Shared instance of LoggingManager for global access.
    static let shared = LoggingManager()
    
    // MARK: - Properties
    
    /// The file URL where logs will be stored.
    private let logFileURL: URL
    
    /// Date formatter for timestamping log entries.
    private let dateFormatter: DateFormatter
    
    // MARK: - Initializer
    
    private init() {
        // Initialize the date formatter.
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        // Determine the log file URL in the app's documents directory.
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            logFileURL = documentsDirectory.appendingPathComponent("app_logs.txt")
        } else {
            fatalError("Unable to access documents directory for logging.")
        }
        
        // Create the log file if it doesn't exist.
        createLogFileIfNeeded()
    }
    
    // MARK: - Log File Management
    
    /// Creates the log file if it does not already exist.
    private func createLogFileIfNeeded() {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: logFileURL.path) {
            let success = fileManager.createFile(atPath: logFileURL.path, contents: nil, attributes: nil)
            if success {
                print("Log file created at \(logFileURL.path)")
            } else {
                print("Failed to create log file at \(logFileURL.path)")
            }
        }
    }
    
    // MARK: - Logging Methods
    
    /// Logs a general action or event.
    /// - Parameter message: The message to log.
    func logAction(_ message: String) {
        let timestampedMessage = "[ACTION] \(currentTimestamp()) - \(message)"
        appendToLogFile(message: timestampedMessage)
    }
    
    /// Logs an error.
    /// - Parameter message: The error message to log.
    func logError(_ message: String) {
        let timestampedMessage = "[ERROR] \(currentTimestamp()) - \(message)"
        appendToLogFile(message: timestampedMessage)
    }
    
    /// Logs a debug message.
    /// - Parameter message: The debug message to log.
    func logDebug(_ message: String) {
        let timestampedMessage = "[DEBUG] \(currentTimestamp()) - \(message)"
        appendToLogFile(message: timestampedMessage)
    }
    
    /// Appends a message to the log file.
    /// - Parameter message: The message to append.
    private func appendToLogFile(message: String) {
        guard let data = (message + "\n").data(using: .utf8) else {
            print("Failed to convert log message to data.")
            return
        }
        
        if let fileHandle = try? FileHandle(forWritingTo: logFileURL) {
            defer {
                fileHandle.closeFile()
            }
            // Seek to the end of the file.
            fileHandle.seekToEndOfFile()
            // Write the data.
            fileHandle.write(data)
        } else {
            // If unable to open file handle, attempt to write data directly.
            do {
                try data.write(to: logFileURL, options: .atomic)
            } catch {
                print("Failed to write log message to file: \(error)")
            }
        }
    }
    
    // MARK: - Utility Methods
    
    /// Returns the current timestamp as a string.
    /// - Returns: A string representing the current date and time.
    private func currentTimestamp() -> String {
        return dateFormatter.string(from: Date())
    }
    
    /// Retrieves the entire log as a string.
    /// - Returns: The log contents if available, otherwise nil.
    func getLogContents() -> String? {
        do {
            let log = try String(contentsOf: logFileURL, encoding: .utf8)
            return log
        } catch {
            print("Failed to read log file: \(error)")
            return nil
        }
    }
    
    /// Clears the log file.
    func clearLogs() {
        do {
            try "".write(to: logFileURL, atomically: true, encoding: .utf8)
            print("Log file cleared.")
        } catch {
            print("Failed to clear log file: \(error)")
        }
    }
}
