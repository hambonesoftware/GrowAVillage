import SwiftUI

// MARK: - View Extensions

extension View {
    /// Applies a shake animation to the view.
    /// - Parameter times: Number of shakes.
    /// - Parameter amplitude: Amplitude of each shake.
    /// - Parameter duration: Duration of each shake.
    /// - Returns: A view with shake animation.
    func shake(times: Int, amplitude: CGFloat = 10, duration: Double = 0.3) -> some View {
        self.modifier(Shake(animatableData: CGFloat(times)))
            .animation(Animation.linear(duration: duration).repeatCount(times, autoreverses: true), value: times)
    }
    
    /// Sets a background gradient for the view.
    /// - Parameters:
    ///   - colors: Array of colors for the gradient.
    ///   - startPoint: Starting point of the gradient.
    ///   - endPoint: Ending point of the gradient.
    /// - Returns: A view with background gradient.
    func backgroundGradient(colors: [Color], startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom) -> some View {
        self.background(
            LinearGradient(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
        )
    }
    
    /// Adds a conditional modifier based on a boolean value.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transformation to apply if the condition is true.
    /// - Returns: A view with the conditional modifier applied.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - String Extensions

extension String {
    /// Truncates the string to a specified length, adding ellipsis if necessary.
    /// - Parameter length: The maximum length of the string.
    /// - Returns: A truncated string with ellipsis if truncated.
    func truncated(to length: Int) -> String {
        return self.count > length ? String(self.prefix(length)) + "…" : self
    }
    
    /// Converts a string to a safe URL by encoding it.
    /// - Returns: An optional URL.
    func toSafeURL() -> URL? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed).flatMap { URL(string: $0) }
    }
}

// MARK: - UIColor Extensions

extension Color {
    /// Initializes a Color from a hexadecimal string.
    /// - Parameter hex: The hexadecimal color string (e.g., "#FF5733").
    init?(hex: String) {
        let r, g, b, a: Double
        
        var hexColor = hex
        if hex.hasPrefix("#") {
            hexColor = String(hex.dropFirst())
        }
        
        guard hexColor.count == 6 || hexColor.count == 8 else {
            return nil
        }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            if hexColor.count == 6 {
                r = Double((hexNumber & 0xFF0000) >> 16) / 255
                g = Double((hexNumber & 0x00FF00) >> 8) / 255
                b = Double(hexNumber & 0x0000FF) / 255
                a = 1.0
            } else {
                r = Double((hexNumber & 0xFF000000) >> 24) / 255
                g = Double((hexNumber & 0x00FF0000) >> 16) / 255
                b = Double((hexNumber & 0x0000FF00) >> 8) / 255
                a = Double(hexNumber & 0x000000FF) / 255
            }
            
            self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
            return
        }
        
        return nil
    }
}

// MARK: - Shake Animation

struct Shake: GeometryEffect {
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
                                                10 * sin(animatableData * .pi * 2), y: 0))
    }
}
