//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let vowels   = ["a","e","i","o","u","y"]
    let commons1 = ["b","c","d","g","h","k","l"]
    let commons2 = ["m","n","p","r","s","t","v"]
    let uncommon = ["f","j","q","w","x","z"]
    var status: String = "is error"
    var phrase: String = ""
    var guessed: [String] = [" "]
    let maxTries: Int = 6
    var currentTries: Int = 0
    var vowelButtons: [UIButton!]!
    var button2: UIButton!
    var buttonOn: Bool = false
    var bottomButtonConstraint: NSLayoutConstraint!
    
    // MARK: - Storyboard Connections
    @IBOutlet weak var hangmanContainer: UIView!
    @IBOutlet weak var letterContainer: UIView!
    @IBOutlet weak var statsContainer: UIView!
    @IBOutlet weak var wordView: UIView!
    
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var commonLabel: UILabel!
    @IBOutlet weak var vowelLabel: UILabel!
    @IBOutlet weak var uncommonLabel: UILabel!
    @IBOutlet weak var remainingGuesses: UILabel!
    @IBOutlet weak var wordToGuess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeVowelButtons()
        makeCommonButtons()
        makeUncommonButtons()
        setupWord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateWordLabel() {
        var replaced = ""
        var winner: Bool = true
        for i in phrase.characters {
            if guessed.contains(String(i)) {
                replaced.appendContentsOf(String(i))
            }
            else {
                winner = false
                replaced.appendContentsOf("*")
            }
        }
        wordToGuess?.text = replaced
        if winner {
            self.status = "YOU WIN"
            goForward()
        }
    }
    
    func setupWord() {
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase().lowercaseString
        print(phrase)
        updateWordLabel()
    }
    
    class myButton: UIButton {
        var content: String = ""
    }
    
    func buttonPressed(sender: myButton) {
        let guess = sender.content
        print("button \(guess) pressed")
        if phrase.containsString(guess) {
            print("phrase contains guess \(guess)")
            guessed.append(guess)
        }
        else {
            print("phrase does not contain guess \(guess)")
            currentTries += 1
            if currentTries >= maxTries {
                print("YOU LOSE")
                self.status = "YOU LOSE"
                goForward()
            }
            else {
                remainingGuesses.text = "\(maxTries - currentTries)"
                hangmanImage.image =  UIImage(named: "hangman\(currentTries+1)")
            }
        }
        updateWordLabel()
        sender.backgroundColor = UIColor.grayColor()
        sender.enabled = false
        self.view.layoutIfNeeded()
    }
    
    func goForward() {
        /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewControllerWithIdentifier("EndGame")  as UIViewController?
        self.presentViewController(newVC!, animated: true, completion: nil) */
        performSegueWithIdentifier("EndTheGame", sender: self)
    }
    
    func makeButtons(content: [String], margin: CGFloat, bottom: CGFloat, width: CGFloat = 45.0) {
        for i in 0...content.count-1 {
            let button: myButton = myButton() //UIButton(type: UIButtonType.System)
            button.setTitle(content[i], forState: UIControlState.Normal)
            button.backgroundColor = UIColor.init(red: 0, green: 0.2, blue: 0.8, alpha: 1)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 0
            button.layer.borderColor = UIColor.blackColor().CGColor
            // button.setBackgroundImage(UIImage(named: "BlueButton"), forState: UIControlState.Normal)
            
            button.titleLabel?.font = UIFont.systemFontOfSize(12)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.content = content[i]
            // Set Action for button
            button.addTarget(self, action: Selector("buttonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            
            // Add buttons to container
            letterContainer.addSubview(button)
            
            // Disable Autoresizing constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            let space: CGFloat = width + margin
            let left: CGFloat = 20 + space * CGFloat(i)
            
            // Auto Layout Rules
            let leftEdge = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: letterContainer, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: left)
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: letterContainer, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1.0, constant: bottom)
            
            let heightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
            
            let widthConstraint  = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: width)
            
            // Add all constraints
            letterContainer.addConstraints([leftEdge, bottomConstraint, heightConstraint, widthConstraint])
        }
    }
    
    func makeVowelButtons() {
        let margin: CGFloat = 12
        let bottom: CGFloat = -255
        makeButtons(vowels, margin: margin, bottom: bottom)
    }
    
    func makeCommonButtons() {
        let margin: CGFloat = 8
        let width: CGFloat = 40
        let bottom1: CGFloat = -170
        let bottom2: CGFloat = -110
        makeButtons(commons1, margin: margin, bottom: bottom1, width: width)
        makeButtons(commons2, margin: margin, bottom: bottom2, width: width)
    }
    
    func makeUncommonButtons() {
        let margin: CGFloat = 12
        let bottom: CGFloat = -20
        makeButtons(uncommon, margin: margin, bottom: bottom)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest : EndGameViewController = segue.destinationViewController as! EndGameViewController
        dest.status = self.status
    }

}
