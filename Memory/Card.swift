import Foundation

struct Card {
    var id: Int
    var isFlipped = false
    var isMatched = false
    
    private static var idFactory = 0
    
    private static func getUniqueId() -> Int {
        Card.idFactory += 1
        return Card.idFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
}
