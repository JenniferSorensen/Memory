//
//  ThemeChooserViewController.swift
//  Memory
//
//  Created by Jennifer Sorensen on 04.11.19.
//  Copyright © 2019 Jennifer Sorensen. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    private lazy var themes = getThemesArray()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle {
                let theme = getThemeWith(name: themeName)
                
                if let mvc = segue.destination as? MemoryViewController {
                    mvc.theme = theme
                }
            }
        }
    }
    
    private func getThemeWith(name: String) -> Theme {
        if name == "Random" {
            return getRandomTheme()
        }
        
        for theme in themes {
            if theme.name == name {
                return theme
            }
        }
        return themes[0]
    }
    
    private func getRandomTheme() -> Theme {
        let randomThemeId = themes.count.arc4random
        
        return themes[randomThemeId]
    }
    
    private func getThemesArray() -> [Theme] {
        var themes: [Theme] = []
        themes.append(Theme(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cardColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),emojiChoices: "⛄️❄️🎄🌬🌨☃️🥛🍪🌌💠🤒🐇", name: "Winter"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), cardColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),emojiChoices: "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮", name: "Animals"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),emojiChoices: "🍭🙀🍬🍁☠️🕷🕸👻😈👿👹🎃", name: "Halloween"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), cardColor: #colorLiteral(red: 0.5262701511, green: 0.2519584, blue: 0, alpha: 1),emojiChoices: "🌲🌳🌴🌱🌿🍀🎋🍃🍂🍄🌾💐", name: "Plants"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0.9657920003, green: 0.6433867812, blue: 0, alpha: 1), cardColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1),emojiChoices: "🍱🍛🍚🍙🍘🍣📱🀄️🐼🍜🍲🍥", name: "Asia"))
        themes.append(Theme(backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), cardColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),emojiChoices: "💛💚💙💜🖤❣️💕💞💗💖💘💝", name: "Love"))
        return themes
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
