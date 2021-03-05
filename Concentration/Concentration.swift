//
//  Concentration.swift
//  Concentration
//
//  Created by Julea Parkhomava on 2/22/21.
//

import Foundation

struct Concentration{
    private(set) var cards = [Card]()
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Number of pairs should be at least 1")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(index: \(index): card index in not in cards")
        if !cards[index].isMatched {
            if let indexOfOpenCard = indexOfOneAndOnlyFaceUpCard, indexOfOpenCard != index {
                if cards[indexOfOpenCard] == cards[index] {
                    cards[indexOfOpenCard].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{
                for indexDop in cards.indices {
                    cards[indexDop].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}

extension Collection{
    var oneAndOnly: Element?{
        return self.count == 1 ? self.first : nil
    }
}
