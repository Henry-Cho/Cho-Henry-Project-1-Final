//
//  SetGameViewModel.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/25/23.
//

import SwiftUI

@Observable class SetGameViewModel {
    private var game = SetGameModel()
    
    var deck: [Card] {
        game.deck
    }
    
    var cardsOnScreen: [Card] {
        game.cardsOnScreen
    }
    
    var score: Int {
        game.score
    }
    
    var dealMoreCardsDisabled: Bool {
        if game.deck.count == 0 && game.cardsFilter(.matched).count != 0 {
            return false
        } else if game.deck.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    func choose(_ card: Card) {
        withAnimation(.easeInOut(duration: CardConstants.animationDuration)) {
            // Remove matched cards and deal new cards
            let matchedCards = game.cardsFilter(.matched)

            if matchedCards.count > 0 {
                for (index, card) in matchedCards.enumerated() {
                    withAnimation(game.deck.count > 0 ? .linear.delay(Double(index) * 0.1) : .default) {
                        let cardIndex = game.removeCard(card)
                        game.dealCard(insertAt: cardIndex)
                    }
                }
                return
            }
            
            game.choose(card)

            // Unselect unmatched cards
            let unmatchedCards = game.cardsFilter(.unmatched)

            if unmatchedCards.count > 0 {
                for card in unmatchedCards {
                    game.updateCardState(card, with: .unselected)
                }
            }

            // Check selected cards are matching or not
            let selectedCards = game.cardsFilter(.selected)

            if selectedCards.count == 3 {
                let isValidSet = game.isSet(selectedCards)

                for card in selectedCards {
                    if isValidSet {
                        game.updateCardState(card, with: .matched)
                    } else {
                        game.updateCardState(card, with: .unmatched)
                    }
                }

                game.updateScore(with: isValidSet ? 1 : -1)
            }
        }
    }

    
    func initialDealCards() {
        withAnimation(.easeInOut(duration: CardConstants.animationDuration)) {
            game.dealTwelveCards()
        }
    }
    
    func newGame() {
        withAnimation(.easeInOut(duration: CardConstants.animationDuration)) {
            game = SetGameModel()
            game.dealTwelveCards()
        }
    }
    
    func dealCard() {
        game.dealCard()
    }
    
    
}
