//
//  SetCardGameView.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import SwiftUI

struct SetCardGameView: View {
    var game: SetCardGameViewModel

    var body: some View {
        NavigationStack {
            VStack {
                gameBody
                    .onAppear {
                        // I need this delay to make the intial animation run
                        delay(duration: 0) {
                            game.initialDealCard()
                        }
                    }
                HStack {
                    score

                    Spacer()

                    deck
                        .animation(nil, value: game.deck)
                }
                .padding()
            }
            .navigationTitle("Set")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    newGameButton
                }
            }
        }
    }

    var gameBody: some View {
        AspectVGrid(items: game.cardsOnScreen, aspectRatio: DC.aspectRatio) { card in
            CardView(card: card, aspectRatio: DC.aspectRatio)
                .cardify(isFaceUp: true)
                .padding(DC.padding)
                .transition(AnyTransition.asymmetric(
                    insertion: .offset(randomOnscreenLocation),
                    removal: .offset(randomOffscreenLocation)
                ))
                .onTapGesture {
                    game.choose(card)
                }
        }
    }

    var newGameButton: some View {
        Button("New Game") {
            withAnimation {
                game.newGame()
            }
        }
    }
    
    func delay(duration: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: closure)
    }
    
    private var randomOnscreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let angle = Double.random(in: 0..<360)
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGSize(width: x, height: y)
    }
    
    private var randomOffscreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let angle = Double.random(in: 0..<360)
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGSize(width: x, height: y)
    }

    var score: some View {
        Text("Score: \(game.score)")
            .font(.title.bold())
    }

    var deck: some View {
        ZStack {
            ForEach(game.deck) { card in
                CardView(card: card)
                    .cardify(isFaceUp: !game.deck.contains(card))
            }
        }
        .frame(width: CardConstants.width, height: CardConstants.height)
        .padding(.horizontal)
        .onTapGesture {
            for index in 0..<3 {
                withAnimation(.linear.delay(Double(index) * DC.dealAnimationDelay)) {
                    game.dealCard()
                }
            }
        }
    }

    func zIndex(of card: Card, in cards: [Card]) -> Double {
        Double((cards.firstIndex(of: card) ?? 0))
    }

    func offset(of card: Card, in cards: [Card]) -> CGSize {
        let index = cards.firstIndex(of: card) ?? 0
        return CGSize(width: 0, height: -index)
    }
}

extension SetCardGameView {
    private typealias DC = DrawingConstants

    struct DrawingConstants {
        static let aspectRatio: CGFloat = 2/3
        static let padding: CGFloat = 5

        static let dealMoreCardsImage = "rectangle.portrait.on.rectangle.portrait.angled.fill"

        static let dealAnimationDelay: Double = 0.1
    }
}

extension SetCardGameView {
    struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let height: CGFloat = 90
        static let width = height * aspectRatio
        static let animationDuration = 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardGameView(game: SetCardGameViewModel())
    }
}
