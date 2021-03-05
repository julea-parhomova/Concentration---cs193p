//
//  Card.swift
//  Concentration
//
//  Created by Julea Parkhomava on 2/22/21.
//

import Foundation

struct Card: Hashable{
    var isMatched: Bool = false
    var isFaceUp: Bool = false
    private var identifier: Int
    
    static var identifierFactory: Int = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        identifier = Card.getUniqueIdentifier()
    }
    
    static func ==(first: Card, second: Card) -> Bool{
        first.identifier == second.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
}
