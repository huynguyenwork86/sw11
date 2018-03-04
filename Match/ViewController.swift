//
//  ViewController.swift
//  Match
//
//  Created by Huy Nguyen on 3/4/18.
//  Copyright © 2018 huynguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            chooseCard(emoji: emojiChoices[cardNumber], on: sender)
        }
        else{
            print("error - selected card is not in the list")
        }
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
}

