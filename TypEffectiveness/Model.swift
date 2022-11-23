//
//  TypeEffectiveness.swift
//  TypEffectiveness
//
//  Created by Martin Plut on 1/7/22.
//

import Foundation

class TypeEffectiveness{
    private(set) var cards =  [Card]()
    var DamageX2 = [String]()
    var DamageX1 = [String]()
    var DamageXhalf = [String]()
    var DamageX0 = [String]()
    var position = "Attacking"
    let types = [
        "normal", "fighting", "flying", "poison", "ground",
        "rock", "bug", "ghost", "steel", "fire", "water",
        "grass", "electric", "psychic", "ice", "dragon",
        "dark", "fairy"
    ]
    // stats[x][y] = damage multiplier
    // stats [0][1] = normal type attack multiplier against fighting defense 
    let stats = [
        [1,1,1,1,1,0.5,1,0,0.5,1,1,1,1,1,1,1,1,1],
        [2,1,0.5,0.5,1,2,0.5,0,2,1,1,1,1,0.5,2,1,2,0.5],
        [1,2,1,1,1,0.5,2,1,0.5,1,1,2,0.5,1,1,1,1,1],
        [1,1,1,0.5,0.5,0.5,1,0.5,0,1,1,2,1,1,1,1,1,2],
        [1,1,0,2,1,2,0.5,1,2,2,1,0.5,2,1,1,1,1,1],
        [1,0.5,2,1,0.5,1,2,1,0.5,2,1,1,1,1,2,1,1,1],
        [1,0.5,0.5,0.5,1,1,1,0.5,0.5,0.5,1,2,1,2,1,1,2,0.5],
        [0,1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5,1],
        [1,1,1,1,1,2,1,1,0.5,0.5,0.5,1,0.5,1,2,1,1,2],
        [1,1,1,1,1,0.5,2,1,2,0.5,0.5,2,1,1,2,0.5,1,1],
        [1,1,1,1,2,2,1,1,1,2,0.5,0.5,1,1,1,0.5,1,1],
        [1,1,0.5,0.5,2,2,0.5,1,0.5,0.5,2,0.5,1,1,1,0.5,1,1],
        [1,1,2,1,0,1,1,1,1,1,2,0.5,0.5,1,1,0.5,1,1],
        [1,2,1,2,1,1,1,1,0.5,1,1,1,1,0.5,1,1,0,1],
        [1,1,2,1,2,1,1,1,0.5,0.5,0.5,2,1,1,0.5,2,1,1],
        [1,1,1,1,1,1,1,1,0.5,1,1,1,1,1,1,2,1,0],
        [1,0.5,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5,0.5],
        [1,2,1,0.5,1,1,1,1,0.5,0.5,1,1,1,1,1,2,2,1]
    ]

    
    private var selectedCardIndex: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    func clearArrays(){
        DamageX0 = [String]()
        DamageX1 = [String]()
        DamageXhalf = [String]()
        DamageX2 = [String]()
    }
    func chooseCard(at index: Int){
        
        selectedCardIndex = index
        clearArrays()
        if position == "Attacking" {findStrengths(idx: index)}
        else                       {findWeaknesses(idx: index)}

    }
    func findStrengths(idx: Int){
        for i in stats[idx].indices{
            if stats[idx][i] == 0{
                DamageX0.append(types[i])
            }
            else if stats[idx][i] == 0.5{
                DamageXhalf.append(types[i])
            }
            else if stats[idx][i] == 1{
                DamageX1.append(types[i])
            }
            else if stats[idx][i] == 2 {
                DamageX2.append(types[i])
            }
        }
    }
    
    func findWeaknesses(idx: Int){
        for i in stats[idx].indices{
            if stats[i][idx] == 0{
                DamageX0.append(types[i])
            }
            else if stats[i][idx] == 0.5{
                DamageXhalf.append(types[i])
            }
            else if stats[i][idx] == 1{
                DamageX1.append(types[i])
            }
            else if stats[i][idx] == 2 {
                DamageX2.append(types[i])
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
    }
    
    func changePosition(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            selectedCardIndex = nil
        }
        
    }

}
