import Foundation
import UIKit

struct Theme
{
    var colors: (background: UIColor, cards: UIColor)
    var emojiChoices: String
    var name : String
    private var emojiChoicesOriginal: String
    
    init(backgroundColor: UIColor, cardColor: UIColor, emojiChoices: String, name: String) {
        colors = (backgroundColor, cardColor)
        self.emojiChoices = emojiChoices
        self.emojiChoicesOriginal = emojiChoices
        self.name = name
    }
    
    public mutating func resetEmojiChoices() {
        emojiChoices = emojiChoicesOriginal
    }
}
