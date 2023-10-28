//
//  SetGameModel\.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/24/23.
//

import Foundation

struct SetGameModel {
    private(set) var deck: [Card] = []
    private(set) var cardsOnScreen: [Card] = []
    private(set) var score = 0
    
    init() {
        for color in CardColor.allCases {
            for shading in CardShading.allCases {
                for symbol in CardSymbol.allCases {
                    for number in CardNumber.allCases {
                        deck.append(
                            Card(
                                color: color,
                                number: number,
                                symbol: symbol,
                                shading: shading
                            )
                        )
                    }
                }
            }
        }
        deck.shuffle()
    }
    
    func cardsFilter(_ state: Card.State) -> [Card] {
        cardsOnScreen.filter{ $0.state == state }
    }
    
    mutating func dealTwelveCards() {
        cardsOnScreen.append(contentsOf: deck[..<12])
        deck.removeSubrange(..<12)
    }
    
    mutating func choose(_ card: Card) {
        guard let selectedCardIdx = cardsOnScreen.firstIndex(of: card) else { return }
        
        cardsOnScreen[selectedCardIdx].state.toggle()
    }
    
    mutating func updateCardState(_ card: Card, with state: Card.State) {
        guard let index = cardsOnScreen.firstIndex(of: card) else { return }

        cardsOnScreen[index].state = state
    }
    
    mutating func updateScore(with value: Int) {
        score += value
    }
    
    mutating func dealCard(insertAt index: Int? = nil) {
        guard deck.count > 0 else { return }

        let card = deck.removeFirst()

        if let index, index < cardsOnScreen.count {
            cardsOnScreen.insert(card, at: index)
        } else {
            cardsOnScreen.append(card)
        }
    }
    
    mutating func removeCard(_ card: Card) -> Int? {
        guard let index = cardsOnScreen.firstIndex(of: card) else { return nil }

        cardsOnScreen.remove(at: index)

        return index
    }
    
    func isSet(_ cards: [Card]) -> Bool {
        let colorComparison = cards.allCompare(\.color)
        let numberComparison = cards.allCompare(\.number)
        let shadingComparison = cards.allCompare(\.shading)
        let symbolComparison = cards.allCompare(\.symbol)

        let colorIsSet = colorComparison == .allSame || colorComparison == .allDifferent
        let numberIsSet = numberComparison == .allSame || numberComparison == .allDifferent
        let shadingIsSet = shadingComparison == .allSame || shadingComparison == .allDifferent
        let symbolIsSet = symbolComparison == .allSame || symbolComparison == .allDifferent

        return colorIsSet && numberIsSet && shadingIsSet && symbolIsSet
    }

}
