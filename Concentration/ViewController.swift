//
//  ViewController.swift
//  Concentration
//
//  Created by Gilbert Marpuri on 01/08/2018.
//  Copyright © 2018 Gilbert Marpuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var emojiStrings = ["🐮","🐶","🦊","🐸","A","B","C","D"]
    
    var cardsWithEmoji = [String]()

    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    
    var cards: [UIButton] = [UIButton]()
    var myCards = [UIButton]()
    
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
        for c in myCards {
            c.removeFromSuperview()
        }
        
        numberOfCards += 2
        if (numberOfCards > 10) {
            numberOfCards = 10
        }
        
        createCards(by: numberOfCards)
    }
    
    @IBAction func createButtons(_ sender: UIButton){
        for c in myCards {
            c.removeFromSuperview()
        }
        
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
        
        for card in stringListForCards {
            
            if (xIndexer > 1) {
                xIndexer = 0
                yPos = yPos + 120
            }
            
            xPos = xPosArrayForTwoRows[xIndexer]
            xIndexer += 1
            
            let myButton = UIButton(frame: CGRect(x: xPos, y: yPos, width: 80, height: 80))
            
            myButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            myButton.setTitle(card, for: UIControlState.normal)
            myButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
            self.view.addSubview(myButton)
            myCards.append(myButton)
        }
    }
    
    override func viewDidLoad() {
        
//        cards.append(card1);
//        cards.append(card2);
//        cards.append(card3);
//        cards.append(card4);
//
//        var charNumberHolder = 1
//
//        for card in cards {
//            if (card.currentTitle == nil) {
//                let emojiCharactersIndex = Int(arc4random_uniform(UInt32(emojiCharacters.count)));
//
//                let emojiString = emojiCharacters[emojiCharactersIndex].emoji!
//                card.setTitle(emojiString, for: UIControlState.normal)
//                emojiCharacters[emojiCharactersIndex].count += 1
//
//                let cardWithEmoji = EmojiChar(emoji: emojiString, count: 0, cardNumber: charNumberHolder)
//                print(cardWithEmoji)
//                charNumberHolder += 1
//
//                cardsWithEmoji.append(cardWithEmoji)
//
//                if (emojiCharacters[emojiCharactersIndex].count > 1)
//                {
//                    emojiCharacters.remove(at: emojiCharactersIndex)
//                }
//            }
//        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flip(on: sender);
    }
    
    func flip(on button: UIButton)
    {
        let index = button.tag;
        let cardTitle = emojiStrings[index-1]
        
        if (button.currentTitle == "") {
            button.setTitle(cardTitle, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
            
        else {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        
    }

}

