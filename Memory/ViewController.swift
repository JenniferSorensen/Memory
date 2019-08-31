import UIKit

class ViewController: UIViewController {
    lazy var game = Memory(numberOfPairsOfCards: (buttons.count + 1) / 2)
    
    var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
    var emojiChoices = ["🌝", "⭐️", "🌹" ,"🌍" ,"🍓" ,"❤️"]
    var emojiDict = [Int:String]()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = buttons.firstIndex(of: sender) {
            game.chooseCard(atIndex: cardNumber)
            updateViewFromModel()
            flipCount += 1
        }
    }
    
    func updateViewFromModel() {
        for index in buttons.indices {
            let button = buttons[index]
            let card = game.cards[index]
            
            if !card.isFlipped {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0) : #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
                button.setTitle("", for: UIControl.State.normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
            }
        }
    }
    
    func getEmoji(for card:Card) -> String {
        if emojiDict[card.id] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojiDict[card.id] = emojiChoices.remove(at: randomIndex)
        }
        return emojiDict[card.id] ?? "?"
    }
}

