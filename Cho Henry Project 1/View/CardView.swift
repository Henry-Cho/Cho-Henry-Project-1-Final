//
//  CardView.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import SwiftUI

struct CardView: View {
    let card: Card

    var aspectRatio = DrawingConstants.aspectRatio

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: 0)
                ForEach(0..<card.number.rawValue, id: \.self) { _ in
                    ZStack {
                        strokedSymbol(for: geometry.size)
                            .foregroundColor(cardColor)
                        filledSymbol
                            .opacity(cardShading)
                    }
                    .rotationEffect(Angle(degrees: card.shape == .squiggle ? 90 : 0))
                    .aspectRatio(2, contentMode: .fit)
                }
                Spacer(minLength: 0)
            }
            .padding(geometry.size.height * 0.15)
            .foregroundColor(cardColor)
            .background(cardBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: DC.cornerRadius))
        }
    }

    private var cardBackgroundColor: Color? {
        switch card.state {
        case .selected:
            return DC.selectedBackgroundColor
        case .unmatched:
            return DC.unmatchedBackgroundColor
        case .matched:
            return DC.matchedBackgroundColor
        default:
            return nil
        }
    }

    private var cardColor: Color {
        switch card.color {
        case .red:
            return .red
        case .green:
            return .green
        case .purple:
            return .purple
        }
    }

    private var cardShading: CGFloat {
        switch card.shading {
        case .solid:
            return 1
        case .striped:
            return 0.5
        case .open:
            return 0
        }
    }
    
    @ViewBuilder
    func strokedSymbol(for size: CGSize) -> some View {
        switch card.shape {
        case .diamond:
            Diamond()
                .stroke(lineWidth: size.height * 0.02)
        case .squiggle:
            GeometryReader { geometry in
                Squiggle()
                    .offset(CGSize(width: -geometry.size.width * 3 / 8, height: 0))
                    .scale(2.0)
                    .stroke(lineWidth: size.height * 0.02)
            }
                
        case .oval:
            Capsule()
                .stroke(lineWidth: size.height * 0.02)
        }
    }

    @ViewBuilder
    private var filledSymbol: some View {
        switch card.shape {
        case .diamond:
            Diamond()
                .fill(cardColor)
        case .squiggle:
            GeometryReader { geometry in
                Squiggle()
                    .offset(CGSize(width: -geometry.size.width * 3 / 8, height: 0))
                    .scale(2.0)
                    .fill(cardColor)
            }
            
        case .oval:
            Capsule()
                .fill(cardColor)
        }
    }
}

extension CardView {
    private typealias DC = DrawingConstants

    private struct DrawingConstants {
        static let aspectRatio: CGFloat = 2/3
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let spacing: CGFloat = 10

        static let selectedBackgroundColor: Color = .cyan.opacity(0.3)
        static let matchedBackgroundColor: Color = .green.opacity(0.3)
        static let unmatchedBackgroundColor: Color = .red.opacity(0.3)
    }
}

#Preview {
    CardView(card: Card(color: .purple, number: .three, shading: .striped, shape: .squiggle, state: .unselected))
        .padding(10)
        .aspectRatio(5/7, contentMode: .fit)
}
