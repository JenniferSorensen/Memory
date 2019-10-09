import UIKit

class ViewController: UIViewController {
    //lazy vars
    lazy private var game = Memory(numberOfPairsOfCards: numberOfPairsOfCards)
    lazy private var theme = getRandomTheme(themesArray: getThemesArray())
    
    //vars
    private var emojiDict = [Card:String]()
    
    //computed properties
    var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    
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
        applyNewTheme()
        updateViewFromModel()
        
        for button in cardButtons {
            button.isEnabled = true
        }
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        roundButtonCorners()
        applyNewTheme()
        updateViewFromModel()
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
    
    private func applyNewTheme() {
        theme = getRandomTheme(themesArray: getThemesArray())
        self.view.backgroundColor = theme.colors.background
    }
    
    private func getRandomTheme(themesArray themes: [Theme]) -> Theme {
        let randomThemeId = getThemesArray().count.arc4random
        
        return themes[randomThemeId]
    }
    
    private func getThemesArray() -> [Theme] {
        var themes: [Theme] = []
        themes.append(Theme(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cardColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),emojiChoices: "⛄️❄️🎄🌬🌨☃️🥛🍪🌌💠🤒🐇"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), cardColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),emojiChoices: "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),emojiChoices: "🍭🙀🍬🍁☠️🕷🕸👻😈👿👹🎃"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), cardColor: #colorLiteral(red: 0.5262701511, green: 0.2519584, blue: 0, alpha: 1),emojiChoices: "🌲🌳🌴🌱🌿🍀🎋🍃🍂🍄🌾💐"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0.9657920003, green: 0.6433867812, blue: 0, alpha: 1), cardColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1),emojiChoices: "🍱🍛🍚🍙🍘🍣📱🀄️🐼🍜🍲🍥"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), cardColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),emojiChoices: "💛💚💙💜🖤❣️💕💞💗💖💘💝"))
        return themes
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

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

