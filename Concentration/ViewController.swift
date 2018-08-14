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
        var touched: Bool
    }
    
    var numberOfTouchedCard = 0
    var previousCardIndex: Int!
    
    var emojiStrings = ["🐮","🐶","🦊","🐸","🍔","🍟","🍕","🍗"]
    
    var cardsWithEmoji = [String]()
    var isFlippingCurrently = false

    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    
    var cards = [Card]()
    
    var numberOfCards = 4
    let MIN_NUMBER_OF_CARDS = 4
    let MAX_NUMBER_OF_CARDS = 10
    
    var xPosArrayForTwoRows = [90, 210]
    
    func pickRandomElements(in stringArray: [String], by numberOfCards: Int) -> [String]
    {
        var sequenceOfStrings = [String]()
        var listOfStringsToUse = [String]()
        var originalListOfStrings = stringArray //temporarily holds the list
        
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
    
    @IBAction func minusButtonAction(_ sender: UIButton) {
        for card in cards {
            card.button.removeFromSuperview()
        }
        cards.removeAll()
        createCards(by: 4)
    }
    
    func createCards(by value: Int) {
        
        let stringListForCards = pickRandomElements(in: emojiStrings, by: value)
        
        var xPos = 0
        var yPos = 50
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
            
            myButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            myButton.setTitle("", for: UIControlState.normal)
            myButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
            myButton.addTarget(self, action: #selector(flipCard), for: .touchUpInside)
            myButton.tag = cardIndex
            cardIndex += 1
            self.view.addSubview(myButton)
            
            let localCard = Card(button: myButton, buttonTitle: titleOfCard, matched: false, touched: false)
            cards.append(localCard)
        }
    }
    
    @objc func flipCard(on button: UIButton)
    {
        if (!isFlippingCurrently) {
            
            numberOfTouchedCard += 1
            
            let cardIndex = button.tag - 1;
            
            if (cardIndex != previousCardIndex) {
                
                var card = cards[cardIndex];
                card.touched = true;
                
                let cardButton = card.button;
                cardButton.setTitle(card.buttonTitle, for: UIControlState.normal)
                cardButton.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                
                if (numberOfTouchedCard == 1) {
                    previousCardIndex = cardIndex;
                }
                
                if (numberOfTouchedCard >= 2) {
                    isFlippingCurrently = true;
                    if (cards[previousCardIndex].buttonTitle == cards[cardIndex].buttonTitle) {
                        cards[previousCardIndex].matched = true;
                        cards[cardIndex].matched = true;
                    }
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.flipAllCardsBackwards();
                        
                        var totalCardMatched = 0;
                        
                        for card in self.cards {
                            if (card.matched == true) {
                                totalCardMatched += 1;
                            }
                        }
                        
                        if (totalCardMatched >= self.numberOfCards) {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                self.increaseNumberOfCards();
                            }
                        }
                        
                        self.isFlippingCurrently = false
                    }
                    
                    numberOfTouchedCard = 0
                }
            }
        }
    }
    
    func increaseNumberOfCards()
    {
        for card in cards {
            card.button.removeFromSuperview();
        }
        cards.removeAll();
        
        numberOfCards += 2
        if (numberOfCards > 10) {
            numberOfCards = 10
        }
        createCards(by: numberOfCards)
    }
    
    func flipAllCardsBackwards()
    {
        for card in cards {
            if (card.matched == false ) {
                let buttonn = card.button
                buttonn.setTitle("", for: UIControlState.normal)
                buttonn.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        }
    }
    
    override func viewDidLoad() {
        createCards(by: numberOfCards)
    }
}

