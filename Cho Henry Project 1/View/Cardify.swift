//
//  Cardify.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

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
                let shape = RoundedRectangle(cornerRadius: 10)

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
}
