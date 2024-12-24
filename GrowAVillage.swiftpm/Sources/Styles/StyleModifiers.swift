import SwiftUI

/// A ViewModifier for standardizing button styles.
struct StandardButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.Fonts.body)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Theme.Colors.primary)
            .cornerRadius(Theme.CornerRadius.buttonRadius)
            .shadow(color: Theme.Shadows.defaultShadow.color,
                    radius: Theme.Shadows.defaultShadow.radius,
                    x: Theme.Shadows.defaultShadow.x,
                    y: Theme.Shadows.defaultShadow.y)
    }
}

/// A ViewModifier for standardizing text input styles.
struct StandardTextInputStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.Fonts.body)
            .padding()
            .background(Theme.Colors.background)
            .cornerRadius(Theme.CornerRadius.defaultRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.defaultRadius)
                    .stroke(Theme.Colors.secondary, lineWidth: 1)
            )
            .shadow(color: Theme.Shadows.defaultShadow.color,
                    radius: Theme.Shadows.defaultShadow.radius,
                    x: Theme.Shadows.defaultShadow.x,
                    y: Theme.Shadows.defaultShadow.y)
    }
}

/// A ViewModifier for standardizing labels.
struct StandardLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.Fonts.headline)
            .foregroundColor(Theme.Colors.textPrimary)
    }
}

/// A ViewModifier for standardizing error messages.
struct ErrorMessageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.Fonts.caption)
            .foregroundColor(Theme.Colors.error)
            .padding([.top], 4)
    }
}

/// A ViewModifier for standardizing success messages.
struct SuccessMessageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.Fonts.caption)
            .foregroundColor(Theme.Colors.success)
            .padding([.top], 4)
    }
}

/// A ViewModifier for standardizing card views.
struct CardViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(Theme.Layout.defaultPadding)
            .background(Theme.Colors.background)
            .cornerRadius(Theme.CornerRadius.defaultRadius)
            .shadow(color: Theme.Shadows.defaultShadow.color,
                    radius: Theme.Shadows.defaultShadow.radius,
                    x: Theme.Shadows.defaultShadow.x,
                    y: Theme.Shadows.defaultShadow.y)
    }
}

/// A ViewModifier for standardizing navigation bar styles.
struct NavigationBarStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("YourApp")
                        .font(Theme.Fonts.title)
                        .foregroundColor(Theme.Colors.textPrimary)
                }
            }
            .background(Theme.Colors.background)
    }
}

/// Extension to make applying modifiers more convenient.
extension View {
    func standardButtonStyle() -> some View {
        self.modifier(StandardButtonStyle())
    }
    
    func standardTextInputStyle() -> some View {
        self.modifier(StandardTextInputStyle())
    }
    
    func standardLabelStyle() -> some View {
        self.modifier(StandardLabelStyle())
    }
    
    func errorMessageStyle() -> some View {
        self.modifier(ErrorMessageStyle())
    }
    
    func successMessageStyle() -> some View {
        self.modifier(SuccessMessageStyle())
    }
    
    func cardViewStyle() -> some View {
        self.modifier(CardViewStyle())
    }
    
    func navigationBarStyle() -> some View {
        self.modifier(NavigationBarStyleModifier())
    }
}
