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
            let randomIndex = Int(arc4random_uniform(UInt32(last)))
            cards.swapAt(last, randomIndex)
            last -= 1
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
}
