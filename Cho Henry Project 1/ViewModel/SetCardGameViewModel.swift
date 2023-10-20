//
//  SetCardGameViewModel.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import SwiftUI

@Observable class SetCardGameViewModel {
    private var model = SetCardGame()
    
    var deck: [Card] {
        model.deck
    }

    var cardsOnScreen: [Card] {
        model.cardsOnScreen
    }

    var score: Int {
        model.score
    }

    var dealMoreCardsDisabled: Bool {
        if model.deck.count == 0 && model.cardsWhich(.matched).count != 0 {
            return false
        } else if model.deck.count == 0 {
            return true
        } else {
            return false
        }
    }

    func newGame() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            model = SetCardGame()
        }
        initialDealCard()
    }

    // MARK: Intents

    func choose(_ card: Card) {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            // Remove matched cards and deal new cards
            let matchedCards = model.cardsWhich(.matched)

            if matchedCards.count > 0 {
                for (index, card) in matchedCards.enumerated() {
                    withAnimation(model.deck.count > 0 ? .linear.delay(Double(index) * 0.1) : .default) {
                        let cardIndex = model.removeCard(card)
                        model.dealCard(insertAt: cardIndex)
                    }
                }
                return
            }
            
            model.choose(card)

            // Unselect unmatched cards
            let unmatchedCards = model.cardsWhich(.unmatched)

            if unmatchedCards.count > 0 {
                for card in unmatchedCards {
                    model.updateCardState(card, with: .unselected)
                }
            }

            // Check selected cards are matching or not
            let selectedCards = model.cardsWhich(.selected)

            if selectedCards.count == 3 {
                let isValidSet = model.isSet(selectedCards)

                for card in selectedCards {
                    if isValidSet {
                        model.updateCardState(card, with: .matched)
                    } else {
                        model.updateCardState(card, with: .unmatched)
                    }
                }

                model.updateScore(with: isValidSet ? 1 : -1)
            }
        }
    }

    func dealCard(insertAt: Int? = nil) {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            model.dealCard(insertAt: insertAt)
        }
    }
    
    func initialDealCard() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            model.dealTwelveCards()
        }
    }
    
    // MARK: - Constants
    private struct Constants {
        static let animationDuration = 0.5
    }
}
