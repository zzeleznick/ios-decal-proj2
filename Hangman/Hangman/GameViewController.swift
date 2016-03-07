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
    
    var vowelButtons: [UIButton!]!
    var button2: UIButton!
    var buttonOn: Bool = false
    var bottomButtonConstraint: NSLayoutConstraint!
    
    // MARK: - Storyboard Connections
    @IBOutlet weak var hangmanContainer: UIView!
    @IBOutlet weak var letterContainer: UIView!
    @IBOutlet weak var statsContainer: UIView!
    @IBOutlet weak var wordView: UIView!
    
    @IBOutlet weak var commonLabel: UILabel!
    @IBOutlet weak var vowelLabel: UILabel!
    @IBOutlet weak var uncommonLabel: UILabel!
    
    @IBOutlet weak var wordToGuess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        makeVowelButtons()
        makeCommonButtons()
        makeUncommonButtons()
        wordToGuess?.text = phrase
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class myButton: UIButton {
        var content: String = ""
    }
    
    func buttonPressed(sender: myButton) {
        print("button \(sender.content) pressed")
        sender.backgroundColor = UIColor.grayColor()
        sender.enabled = false
        self.view.layoutIfNeeded()
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
