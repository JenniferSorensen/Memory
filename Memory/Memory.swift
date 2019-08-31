import Foundation

class Memory {
    var cards = [Card]()
    var indexOfOnlyFaceUpCard: Int?
    
    func chooseCard(atIndex index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].id == cards[index].id {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFlipped = true
                indexOfOnlyFaceUpCard = nil
            } else {
                //either no cards of both cards are flipped
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFlipped = false
                }
                cards[index].isFlipped = true
                indexOfOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
}
