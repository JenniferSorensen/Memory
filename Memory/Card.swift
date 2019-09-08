import Foundation

struct Card: Hashable {
    private var id: Int
    var isFlipped = false
    var isMatched = false
    var alreadySeen = false
    
    private static var idFactory = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
    
    private static func getUniqueId() -> Int {
        Card.idFactory += 1
        return Card.idFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
}
