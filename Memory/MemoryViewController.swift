import UIKit

class MemoryViewController: UIViewController {
    //lazy vars
    private lazy var game = Memory(numberOfPairsOfCards: numberOfPairsOfCards)
    
    //vars
    public var theme = Theme(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cardColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),emojiChoices: "⛄️❄️🎄🌬🌨☃️🥛🍪🌌💠🤒🐇", name: "Winter")
    private var emojiDict = [Card:String]()
    
    //computed properties
    private var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    
    
    //outlets
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender), !(game.cards[cardNumber].isFlipped && game.indexOfOnlyFaceUpCard != nil) {
            game.chooseCard(atIndex: cardNumber)
            updateViewFromModel()
            
            for index in cardButtons.indices {
                if game.cards[index].isMatched, cardButtons[index].isEnabled {
                    cardButtons[index].isEnabled = false
                }
            }
            if game.allCardsMatched {
                for index in cardButtons.indices {
                    cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    cardButtons[index].setTitle("", for: UIControl.State.normal)
                }
            }
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Memory(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        theme.resetEmojiChoices()
        
        for button in cardButtons {
            button.isEnabled = true
        }
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        roundButtonCorners()
        updateViewFromModel()
        self.view.backgroundColor = theme.colors.background
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        self.title = theme.name
    }
    
    private func updateLabel(label: UILabel, with text: String) {
        let attributes : [NSAttributedString.Key:Any] = [
            .strokeWidth : 5,
            .strokeColor : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        label.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            updateLabel(label: scoreLabel, with: "Score: \(game.score)")
            updateLabel(label: flipCountLabel, with: "Flips: \(game.flipCount)")
            
            if !card.isFlipped {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0) : theme.colors.cards
                button.setTitle("", for: UIControl.State.normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
            }
        }
    }
    
    private func getEmoji(for card: Card) -> String {
        if emojiDict[card] == nil, theme.emojiChoices.count > 0 {
            let randomStringIndex = theme.emojiChoices.index(theme.emojiChoices.startIndex, offsetBy: theme.emojiChoices.count.arc4random)
            emojiDict[card] = String(theme.emojiChoices.remove(at: randomStringIndex))
        }
        return emojiDict[card] ?? "?"
    }
    
    private func roundButtonCorners() {
        for button in cardButtons {
            button.backgroundColor = .clear
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
}

