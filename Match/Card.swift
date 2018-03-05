//
//  Card.swift
//  Match
//
//  Created by Huy Nguyen on 3/4/18.
//  Copyright © 2018 huynguyen. All rights reserved.
//

import Foundation
struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    static var identifierFactory = 0
    static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
}
