//
//  Match.swift
//  Match
//
//  Created by Huy Nguyen on 3/4/18.
//  Copyright © 2018 huynguyen. All rights reserved.
//

import Foundation
struct Game{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
//            var foundIndex: Int?
//            for index in cards.indices{
//                if(cards[index].isFaceUp){
//                    if foundIndex == nil{
//                        foundIndex = index
//                    }
//                    else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
            let faceUpCardIndices = cards.indices.filter{cards[$0].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            return faceUpCardIndices.oneAndOnly
        }
        
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Game chooseCard(at: \(index)): chosen card in snot in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if(cards[matchIndex] == cards[index])
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else{
                indexOfOneAndOnlyFaceUpCard = index
            }   
        }
    }
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Game.init(\(numberOfPairsOfCards)")
        for _ in 1...numberOfPairsOfCards {
            let card = Card();
            cards += [card, card]
        }
        cards.shuffle()
//        //TODO: shuffle the cards
    }
}
extension Collection {
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}
extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<count
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
