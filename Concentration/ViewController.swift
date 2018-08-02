//
//  ViewController.swift
//  Concentration
//
//  Created by Gilbert Marpuri on 01/08/2018.
//  Copyright © 2018 Gilbert Marpuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct EmojiChars
    {
        var emoji: String?
        var count: Int
    }
    
    var emojiCharacters =   [
                                EmojiChars(emoji: "🐮", count: 0),
                                EmojiChars(emoji: "🐶", count: 0),
                            ]
    
    
    var numberOfButtons = 4
    
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
        
//        var arr = [1,2,3,4]
//        print(arr[0])
//        arr.remove(at: 0)
//        print(arr.count)
        
        for card in cards {
            if (card.currentTitle == nil) {
                let emojiCharactersIndex = Int(arc4random_uniform(UInt32(emojiCharacters.count)));

                let emoji = emojiCharacters[emojiCharactersIndex].emoji!
                card.setTitle(emoji, for: UIControlState.normal)
                emojiCharacters[emojiCharactersIndex].count += 1

                print(emojiCharacters[emojiCharactersIndex])
                
                if (emojiCharacters[emojiCharactersIndex].count > 1)
                {
                    print("Removed: \(emojiCharacters[emojiCharactersIndex].emoji!) from Array")
                    emojiCharacters.remove(at: emojiCharactersIndex)
                }
            }
        }
    }

    var emojiHolder: String = ""
    var numberOfCardTouched: Int = 0
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard(withEmoji: "🐶", on: sender)
    }
    
    @IBAction func touchSecondCard(_ sender: UIButton) {
        flipCard(withEmoji: "🐮", on: sender)
    }
    
    @IBAction func resetCard(_ sender: UIButton) {
    }
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton)
    {
        numberOfCardTouched += 1
        if (numberOfCardTouched > 2)
        {
            numberOfCardTouched = 1
        }
        print(numberOfCardTouched)
        
        if (button.currentTitle == emoji)
        {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }

}

