import Foundation

class Memory {
    var cards = [Card]()
    
    func chooseCard(atIndex index: Int) {
        if cards[index].isFlipped {
            cards[index].isFlipped = false
        } else {
            cards[index].isFlipped = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
}
