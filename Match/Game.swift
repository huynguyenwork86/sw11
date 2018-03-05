//
//  Match.swift
//  Match
//
//  Created by Huy Nguyen on 3/4/18.
//  Copyright © 2018 huynguyen. All rights reserved.
//

import Foundation
class Game{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if(cards[matchIndex].identifier == cards[index].identifier)
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        }
//        else{
//            cards[index].isFaceUp = true
//        }
        
    }
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card();
            cards += [card, card]
        }
        //TODO: shuffle the cards
    }
}
