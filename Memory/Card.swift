import Foundation

struct Card {
    var id: Int
    var isFlipped = false
    var isMatched = false
    
    static var idFactory = 0
    
    static func getUniqueId() -> Int {
        Card.idFactory += 1
        return Card.idFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
}
