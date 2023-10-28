//
//  Card.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/24/23.
//

import SwiftUI

struct Card: Identifiable, Equatable {
    let id = UUID()
    let color: CardColor
    let number: CardNumber
    let symbol: CardSymbol
    let shading: CardShading
    var state: State = .unselected
}

enum CardColor: CaseIterable {
    case red, green, purple
}

enum CardNumber: Int, CaseIterable {
    case one = 1, two, three
}

enum CardSymbol: CaseIterable {
    case squiggle, diamond, oval
}

enum CardShading: CaseIterable {
    case solid, shaded, none
}

extension Card {
    enum State {
        case matched, unmatched, selected, unselected
        mutating func toggle() {
            switch self {
                case .matched:
                    self = .matched
                case .unmatched:
                    self = .selected
                case .selected:
                    self = .unselected
                case .unselected:
                    self = .selected
            }
        }
    }
}
