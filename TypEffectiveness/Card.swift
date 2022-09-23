//
//  Card.swift
//  TypEffectiveness
//
//  Created by Martin Plut on 1/7/22.
//

import Foundation

struct Card: Hashable{
    var hashValue: Int {return identifier}
    

    var isFaceUp = false
    private var identifier = 0
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
//    static func == (lhs: Card, rhs: Card) -> Bool{
//        return lhs.identifier == rhs.identifier
//    }
    var isMatched = false
}
