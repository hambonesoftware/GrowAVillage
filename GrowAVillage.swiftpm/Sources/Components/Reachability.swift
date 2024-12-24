import Foundation
import SystemConfiguration

/// Monitors network reachability
final class Reachability {
    static let shared = Reachability()
    
    private var reachability: SCNetworkReachability?
    
    private init() {
        let address = sockaddr_in(
            sin_len: UInt8(MemoryLayout<sockaddr_in>.size),
            sin_family: sa_family_t(AF_INET),
            sin_port: 0,
            sin_addr: in_addr(s_addr: 0),
            sin_zero: (0, 0, 0, 0, 0, 0, 0, 0)
        )
        
        var addressCast = withUnsafePointer(to: address) {
            UnsafeRawPointer($0).assumingMemoryBound(to: sockaddr.self)
        }
        
        self.reachability = SCNetworkReachabilityCreateWithAddress(nil, addressCast)
    }
    
    /// Checks if the network is reachable
    func isReachable() -> Bool {
        guard let reachability = reachability else { return false }
        
        var flags = SCNetworkReachabilityFlags()
        if SCNetworkReachabilityGetFlags(reachability, &flags) {
            return flags.contains(.reachable) && !flags.contains(.connectionRequired)
        }
        
        return false
    }
}
