//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Julea Parkhomava on 2/21/21.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairs)
    
    private var numberOfPairs: Int{
        (buttons.count + 1) / 2
    }

    @IBOutlet private weak var flipsCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private(set) var flipsCount = 0{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipsCount)", attributes: attributes)
        flipsCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private var buttons: [UIButton]!
        
    @IBAction private func touchCard(_ sender: UIButton) {
        flipsCount += 1
        if let index = buttons.firstIndex(of: sender){
            game.chooseCard(index: index)
            updateViewFromModel()
        }else{
            print("There is no such button(")
        }
    }
    
    private func updateViewFromModel(){
        if buttons != nil{
            for index in buttons.indices{
                if game.cards[index].isFaceUp{
                    buttons[index].setTitle(emoji(for: game.cards[index]), for: .normal)
                    buttons[index].backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }else{
                    buttons[index].setTitle("", for: .normal)
                    buttons[index].backgroundColor = game.cards[index].isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
    }
    private var emojiChoices = "🦇😱🙀😈👻🎃🕸🕷🧛‍♀️"
    
    var theme: String?{
        didSet{
            emojiChoices = theme!
            emojiDict = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiDict = [Card: String]()
    
    private func emoji(for card: Card) -> String{
        if emojiDict[card] == nil{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emojiDict[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emojiDict[card] ?? "?"
    }
    
}

extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
