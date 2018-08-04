//
//  ViewController.swift
//  Concentration
//
//  Created by Gilbert Marpuri on 01/08/2018.
//  Copyright © 2018 Gilbert Marpuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct EmojiChar
    {
        var emoji: String?
        var count: Int
        var cardNumber: Int
    }
    
    var emojiCharacters =   [
                                EmojiChar(emoji: "🐮", count: 0, cardNumber: 0),
                                EmojiChar(emoji: "🐶", count: 0, cardNumber: 0),
                            ]
    
    var cardsWithEmoji = [EmojiChar]()
    
    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    @IBOutlet weak var card3: UIButton!
    @IBOutlet weak var card4: UIButton!
    
    var cards: [UIButton] = [UIButton]()
    
    override func viewDidLoad() {
        
        cards.append(card1);
        cards.append(card2);
        cards.append(card3);
        cards.append(card4);
        
        var charNumberHolder = 1
        for card in cards {
            if (card.currentTitle == nil) {
                let emojiCharactersIndex = Int(arc4random_uniform(UInt32(emojiCharacters.count)));

                let emojiString = emojiCharacters[emojiCharactersIndex].emoji!
                card.setTitle(emojiString, for: UIControlState.normal)
                emojiCharacters[emojiCharactersIndex].count += 1
                
                let cardWithEmoji = EmojiChar(emoji: emojiString, count: 0, cardNumber: charNumberHolder)
                print(cardWithEmoji)
                charNumberHolder += 1
                
                cardsWithEmoji.append(cardWithEmoji)
                
                if (emojiCharacters[emojiCharactersIndex].count > 1)
                {
                    emojiCharacters.remove(at: emojiCharactersIndex)
                }
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flip(on: sender);
    }
    
    func flip(on button: UIButton)
    {
        let index = button.tag;
        let cardTitle = cardsWithEmoji[index-1].emoji
        
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

