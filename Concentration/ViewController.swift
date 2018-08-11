//
//  ViewController.swift
//  Concentration
//
//  Created by Gilbert Marpuri on 08/01/2018.
//  Copyright © 2018 Gilbert Marpuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Card
    {
        var button: UIButton
        var buttonTitle: String
        var matched: Bool
    }
    
    var firstPick: Card!
    var secondPick: Card!
    
    var emojiStrings = ["🐮","🐶","🦊","🐸","🍔","🍟","🍕","🍗"]
    
    var cardsWithEmoji = [String]()

    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    
    var cards = [Card]()
    
    var numberOfCards = 2
    let MIN_NUMBER_OF_CARDS = 2
    let MAX_NUMBER_OF_CARDS = 10
    
    var xPosArrayForTwoRows = [90, 210]
    
    func pickRandomElements(in arr: [String], by numberOfCards: Int) -> [String]
    {
        var sequenceOfStrings = [String]()
        var listOfStringsToUse = [String]()
        var originalListOfStrings = arr //temporarily holds the list
        
        let halfOfTheNumberOfCards = numberOfCards / 2
        
        for _ in 1 ... halfOfTheNumberOfCards
        {
            let randomIndex = arc4random_uniform(UInt32(originalListOfStrings.count))
            let emoji = originalListOfStrings.remove(at: Int(randomIndex))
            listOfStringsToUse.append(emoji)
        }
        
        while sequenceOfStrings.count < numberOfCards
        {
            let shuffledEmojis = shuffleContents(of: listOfStringsToUse)
            for emoji in shuffledEmojis
            {
                sequenceOfStrings.append(emoji)
            }
        }
        
        return sequenceOfStrings
    }
    
    func shuffleContents(of stringList: [String]) -> [String]
    {
        var sequencedString = [String]()
        var stringListHolder = stringList
        
        for _ in 1 ... stringList.count
        {
            let randomIndexToRemove = arc4random_uniform(UInt32(stringListHolder.count))
            let stringTaken = stringListHolder.remove(at: Int(randomIndexToRemove))
            sequencedString.append(stringTaken)
        }
        
        return sequencedString
    }
    
    
    
    @IBAction func deleteButtons(_ sender: UIButton) {
        for c in cards {
            c.button.removeFromSuperview()
        }
        cards.removeAll()
        
        numberOfCards += 2
        if (numberOfCards > 10) {
            numberOfCards = 10
        }
        
        createCards(by: numberOfCards)
    }
    
    @IBAction func createButtons(_ sender: UIButton){
        for c in cards {
            c.button.removeFromSuperview()
        }
        cards.removeAll()
        
        numberOfCards -= 2
        if (numberOfCards < 2) {
            numberOfCards = 2
        }
        
        createCards(by: numberOfCards)
    }
    
    func createCards(by value: Int) {
        
        let stringListForCards = pickRandomElements(in: emojiStrings, by: value)
        
        var xPos = 0
        var yPos = 90
        var xIndexer = 0
        var cardIndex = 1
        
        for titleOfCard in stringListForCards {
            
            if (xIndexer > 1) {
                xIndexer = 0
                yPos = yPos + 120
            }
            
            xPos = xPosArrayForTwoRows[xIndexer]
            xIndexer += 1
            
            let myButton = UIButton(frame: CGRect(x: xPos, y: yPos, width: 80, height: 80))
            
            myButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            myButton.setTitle(titleOfCard, for: UIControlState.normal)
            myButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
            myButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
            myButton.tag = cardIndex
            cardIndex += 1
            self.view.addSubview(myButton)
            
            let localCard = Card(button: myButton, buttonTitle: titleOfCard, matched: false)
            cards.append(localCard)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.setupCards()
        }
    }
    
    func setupCards()
    {
        for card in cards {
            let btn = card.button
            btn.setTitle("", for: UIControlState.normal)
            btn.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
    }
    
    @objc func pressedButton(on button: UIButton)
    {
        print(firstPick)
        
        
        print(secondPick)
        
        let touchedCard = cards[button.tag]
        let touchedButton = touchedCard.button
        
        if (firstPick == nil) && (secondPick == nil) {
            firstPick = touchedCard
        }
        
        else if (firstPick != nil) && (secondPick == nil) {
            secondPick = touchedCard
        }
        
        print("FP: " + firstPick.buttonTitle)
        
        print("SP: " + secondPick.buttonTitle)
        
        print("pressed " + button.currentTitle!)
        if (touchedButton.currentTitle == "")
        {
            print(button.tag)
            button.setTitle(button.currentTitle!, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        
        else {
            print(button.tag)
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        
    }

}

