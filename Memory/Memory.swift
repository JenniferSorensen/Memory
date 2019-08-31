import Foundation

class Memory {
    var cards = [Card]()
    
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFlipped {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFlipped = (index == newValue)
            }
        }
    }
    
    func chooseCard(atIndex index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index)): Index is not in the cards.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].id == cards[index].id {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFlipped = true
            } else {
                //either no cards of both cards are flipped
                indexOfOnlyFaceUpCard = index
            }
        }
    }
    
    private func shuffleCards() {
        //Fisher-Yates algorithm
        var last = cards.count - 1
        while last > 0 {
            let randomIndex = last.arc4random
            cards.swapAt(last, randomIndex)
            last -= 1
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards): You must have at least one pair of cards.")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
}
