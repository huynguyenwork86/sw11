//
//  ViewController.swift
//  Match
//
//  Created by Huy Nguyen on 3/4/18.
//  Copyright © 2018 huynguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numberOfPairOfCards : Int{
        return (cardButtons.count + 1) / 2
    }
    private lazy var game = Game(numberOfPairsOfCards: numberOfPairOfCards)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private(set) var flipCount = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
//    private var emojiChoices = ["🎃", "👻", "👿", "👹", "👺", "☠️", "💀", "👽"]
    private static let finalEmojiChoices = [
        "🎃👻👿👹👺☠️💀👽",
        "😃😅😊😉😗😛",
        "🐶🐱🐭🐹🐰🦊",
        "🥃🍺🍻🥂🍸🍹"
    ]
    private static func getATheme()->String{
        return finalEmojiChoices[finalEmojiChoices.count.arc4random]
    }
    private lazy var emojiChoices = ViewController.getATheme()
    private var emoji = [Card: String]()
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            udpateViewFromModel()
        }
        else{
            print("error - selected card is not in the list")
        }
    }
    func udpateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if(card.isFaceUp){
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = UIColor.white
            }
            else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }
    func emoji(for card: Card) -> String{
        if emoji[card] == nil, emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    func chooseCard(emoji: String, on button: UIButton){
        if(emoji == button.currentTitle){
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = UIColor.orange
        }
        else{
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = UIColor.white
        }
    }
    @IBAction private func touchNew(_ sender: UIButton) {
        flipCount = 0
        emojiChoices = ViewController.getATheme()
        emoji = [Card:String]()
        game = Game(numberOfPairsOfCards: numberOfPairOfCards)
        udpateViewFromModel()
    }
    
}
extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            return 0
        }
    }
}

