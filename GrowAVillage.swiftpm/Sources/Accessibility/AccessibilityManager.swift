import SwiftUI

/// Manages accessibility features within the application.
final class AccessibilityManager {
    static let shared = AccessibilityManager()
    
    private init() {}
    
    /// Configures accessibility for a given view.
    /// - Parameters:
    ///   - view: The SwiftUI view to configure.
    ///   - identifier: A unique identifier for UI testing.
    ///   - label: The accessibility label describing the view.
    ///   - traits: The accessibility traits defining the behavior of the view.
    func configureAccessibility<V: View>(
        for view: V,
        identifier: String? = nil,
        label: String? = nil,
        traits: AccessibilityTraits? = nil
    ) -> some View {
        view
            .accessibilityLabel(label.map(Text.init) ?? Text(""))
            .accessibilityIdentifier(identifier ?? "")
            .applyAccessibilityTraits(traits)
    }
    
    /// Enables dynamic type support for a given view.
    /// - Parameter view: The SwiftUI view to configure.
    func enableDynamicType<V: View>(for view: V) -> some View {
        view
            .dynamicTypeSize(.medium ... .accessibility5)
    }
    
    /// Sets up VoiceOver announcements.
    /// - Parameter message: The message to announce.
    func announce(message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }
    
    /// Configures the accessibility traits for a button.
    /// - Parameter view: The SwiftUI button view to configure.
    func configureButtonAccessibility<V: View>(for view: V, label: String) -> some View {
        configureAccessibility(for: view, label: label, traits: .isButton)
    }
    
    /// Configures the accessibility traits for a static text.
    /// - Parameter view: The SwiftUI text view to configure.
    func configureStaticTextAccessibility<V: View>(for view: V, label: String) -> some View {
        configureAccessibility(for: view, label: label, traits: .isStaticText)
    }
    
    /// Configures the accessibility traits for an image.
    /// - Parameters:
    ///   - view: The SwiftUI image view to configure.
    ///   - label: The accessibility label describing the image.
    func configureImageAccessibility<V: View>(for view: V, label: String) -> some View {
        configureAccessibility(for: view, label: label, traits: .isImage)
    }
}

/// Enum for supported accessibility traits.
enum AccessibilityTraits {
    case isHeader
    case isButton
    case isImage
    case isStaticText
}

/// Extension to handle applying accessibility traits.
private extension View {
    /// Applies accessibility traits to a view.
    /// - Parameter traits: The traits to apply.
    /// - Returns: The modified view with the traits applied.
    func applyAccessibilityTraits(_ traits: AccessibilityTraits?) -> some View {
        guard let traits = traits else { return self }
        switch traits {
        case .isHeader:
            return self.accessibilityAddTraits(.isHeader)
        case .isButton:
            return self.accessibilityAddTraits(.isButton)
        case .isImage:
            return self.accessibilityAddTraits(.isImage)
        case .isStaticText:
            return self.accessibilityAddTraits(.isStaticText)
        }
    }
}
