import SwiftUI

/// Defines the color palette and font styles used throughout the app.
struct Theme {
    // MARK: - Colors
    
    struct Colors {
        static let primary = Color("PrimaryColor")          // Defined in Assets.xcassets
        static let secondary = Color("SecondaryColor")      // Defined in Assets.xcassets
        static let background = Color("BackgroundColor")    // Defined in Assets.xcassets
        static let textPrimary = Color("TextPrimaryColor")  // Defined in Assets.xcassets
        static let textSecondary = Color("TextSecondaryColor") // Defined in Assets.xcassets
        static let error = Color("ErrorColor")              // Defined in Assets.xcassets
        static let success = Color("SuccessColor")          // Defined in Assets.xcassets
        // Add more colors as needed
    }
    
    // MARK: - Fonts
    
    struct Fonts {
        static let title = Font.system(size: 24, weight: .bold, design: .default)
        static let headline = Font.system(size: 20, weight: .semibold, design: .default)
        static let body = Font.system(size: 16, weight: .regular, design: .default)
        static let caption = Font.system(size: 12, weight: .light, design: .default)
        // Add more fonts or custom font definitions as needed
    }
    
    // MARK: - Shadows
    
    struct Shadows {
        static let defaultShadow = Shadow(color: Colors.textSecondary.opacity(0.2),
                                          radius: 4,
                                          x: 0,
                                          y: 2)
        // Add more shadow styles as needed
    }
    
    // MARK: - Corner Radius
    
    struct CornerRadius {
        static let defaultRadius: CGFloat = 10
        static let buttonRadius: CGFloat = 8
        // Add more corner radius definitions as needed
    }
    
    // MARK: - Layout
    
    struct Layout {
        static let defaultPadding: CGFloat = 16
        static let smallPadding: CGFloat = 8
        static let largePadding: CGFloat = 24
        // Add more layout-related constants as needed
    }
    
    // MARK: - Animations
    
    struct Animations {
        static let defaultDuration: Double = 0.3
        static let springResponse: Double = 0.5
        static let springDamping: Double = 0.7
        // Add more animation-related constants as needed
    }
    
    // MARK: - Other Styles
    
    // Add any additional theming-related structures or properties as needed
}

/// Defines custom shadow parameters.
struct Shadow {
    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat
    
    func modifier() -> some ViewModifier {
        return ShadowModifier(color: color, radius: radius, x: x, y: y)
    }
}

/// A ViewModifier for applying shadows.
struct ShadowModifier: ViewModifier {
    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}
