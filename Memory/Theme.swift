import Foundation
import UIKit

struct Theme
{
    var colors: (background: UIColor, cards: UIColor)
    var emojiChoices: String
    
    init(backgroundColor: UIColor, cardColor: UIColor, emojiChoices: String) {
        colors = (backgroundColor, cardColor)
        self.emojiChoices = emojiChoices
    }
}
