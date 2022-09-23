//
//  ViewController.swift
//  TypEffectiveness
//
//  Created by Martin Plut on 1/7/22.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViewFromModel()
    }
    
    @IBOutlet private var listOfCards: [UIButton]!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet weak var effectivenessText: UITextView!
    
    private lazy var te = TypeEffectiveness(numberOfPairsOfCards:  numberOfPairsOfCards)
    
    
    var numberOfPairsOfCards: Int{ return ((listOfCards.count+1)/2) }
    
    
    private(set) var position = "Attacking" {
        didSet{
            positionLabel.text = "Position: \(position)"
            te.position = position
        }
    }
    
        
    @IBAction func changePosition(_ sender: UIButton) {
        
        te.changePosition()
        if position == "Attacking"{ position = "Defending"}
        else {position = "Attacking"}
        updateViewFromModel()
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
       
        if let cardNumber = listOfCards.firstIndex(of: sender){
            te.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card not in listOfCards")
        }
        
        
    }
    private func listHelper(lst: Array<String>) -> String{
        var x = 0
        var typelist = ""
        if lst.isEmpty{return "None"}
        while x+1 != lst.endIndex{
            typelist.append(contentsOf: lst[x])
            typelist.append(", ")
            x+=1
        }
        typelist.append(contentsOf: lst[x])
        return typelist
    }
    private func createEffectivenessString() -> String{
        
        var effectivenessString = "0x Damage: " + listHelper(lst: te.DamageX0) + "\n"
        effectivenessString += "--------------------------------------" + "\n"
        effectivenessString += ".5x Damage: " + listHelper(lst: te.DamageXhalf) + "\n"
        effectivenessString += "--------------------------------------" + "\n"
//        effectivenessString += "1x Damage: " + listHelper(lst: te.DamageX1) + "\n"
//        effectivenessString += "--------------------------------------" + "\n"
        effectivenessString += "2x Damage: " + listHelper(lst: te.DamageX2) + "\n"
        effectivenessString += "--------------------------------------"
        
        return effectivenessString
        
    }
    private func updateTextView(effectiveness: String){
        effectivenessText.text = effectiveness
    }
    private func updateViewFromModel(){
        for index in listOfCards.indices{
            let button = listOfCards[index]
            let card = te.cards[index]
            
            if(card.isFaceUp){
                button.setTitle(te.types[index], for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle(te.types[index], for: .normal) // set button title for each type
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            }
        }
        updateTextView(effectiveness: createEffectivenessString())
    }
}


