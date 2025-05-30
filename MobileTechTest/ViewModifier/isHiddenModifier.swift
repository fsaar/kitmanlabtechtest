import SwiftUI

struct isHiddenModifier: ViewModifier {
    let isHidden: Bool
    
    func body(content: Self.Content) -> some View {
        if isHidden {
            content.hidden()
        }
        else {
            content
        }
    }
}

extension View {
    func isHidden(isHidden: Bool) -> some View {
        self.modifier(isHiddenModifier(isHidden: isHidden))
    }
}
