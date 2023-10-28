//
//  CardView.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/25/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SymbolView(card: card, size: geometry.size)
            }
            .padding(geometry.size.width * CardConstants.paddingScaleFactor)
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .background(cardBackgroundColor)
        .cardify(isFaceUp: true)
        .aspectRatio(CardConstants.aspectRatio, contentMode: .fit)
    }
    
    private var cardBackgroundColor: Color? {
            switch card.state {
            case .selected:
                return DrawingConstants.selectedBackgroundColor
            case .unmatched:
                return DrawingConstants.unmatchedBackgroundColor
            case .matched:
                return DrawingConstants.matchedBackgroundColor
            default:
                return nil
            }
        }
}

private struct DrawingConstants {
    static let selectedBackgroundColor: Color = .cyan.opacity(0.3)
    static let matchedBackgroundColor: Color = .green.opacity(0.3)
    static let unmatchedBackgroundColor: Color = .red.opacity(0.3)
}

#Preview {
    CardView(card: Card(color: .red, number: .two, symbol: .squiggle, shading: .shaded))
        .padding()
}
