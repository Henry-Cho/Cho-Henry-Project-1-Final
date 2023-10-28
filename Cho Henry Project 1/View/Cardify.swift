import SwiftUI

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

struct Cardify: ViewModifier {
    var isFaceUp = false

    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))

                if isFaceUp {
                    shape
                        .fill(colorScheme == .dark ? .black : .white)
                } else {
                    shape
                }

                shape
                    .strokeBorder(lineWidth: geometry.size.width * 0.02)
                    .foregroundColor(colorScheme == .dark ? .white : .black)


                content.opacity(isFaceUp ? 1 : 0)
            }
        }
    }
    
    // MARK: - Drawing Constants
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.08
    }
}
