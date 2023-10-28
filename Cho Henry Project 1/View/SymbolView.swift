//
//  SymbolView.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/25/23.
//

import SwiftUI

struct SymbolView: View {
    let card: Card
    let size: CGSize
    var color: Color {
        switch card.color {
            case .red:
                .red
            case .green:
                .green
            default:
                .purple
        }
    }
    
    var symbol: some Shape {
        switch card.symbol {
            case .squiggle:
                AnyShape(Squiggle())
            case .diamond:
                AnyShape(Diamond())
            case .oval:
                AnyShape(Oval())
        }
    }
    
    var shading: Color {
        switch card.shading {
            case .solid:
                color.opacity(1)
            case .shaded:
                color.opacity(0.25)
            default:
                .clear
        }
    }
    var body: some View {
        HStack {
            ForEach(0..<card.number.rawValue, id:\.self) { _ in
                ZStack {
                    Group {
                        symbol
                            .foregroundStyle(shading)
                        symbol
                            .stroke(lineWidth: size.width * CardConstants.strokeScaleFactor)
                            .foregroundStyle(color)
                    }
                    .aspectRatio(1/2, contentMode: .fit)
                }
            }
        }
        .rotationEffect(Angle(degrees: 180))
    }
}

#Preview {
    SymbolView(card: Card(color: .green, number: .one, symbol: .oval, shading: .shaded), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        .padding()
}
