//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let vowels = ["a", "e", "i", "o", "u", "y"]
    var vowelButtons: [UIButton!]!
    var button2: UIButton!
    var buttonOn: Bool = false
    var bottomButtonConstraint: NSLayoutConstraint!
    
    // MARK: - Storyboard Connections
    @IBOutlet weak var letterContainer: UIView!
    @IBOutlet weak var commonLabel: UILabel!
    @IBOutlet weak var vowelLabel: UILabel!
    @IBOutlet weak var uncommonLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        makeVowelButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeButtons(content: [String], bottom: CGFloat) {
        for i in 1...content.count-1 {
            let button: UIButton = UIButton(type: UIButtonType.System)
            button.setTitle(content[i], forState: UIControlState.Normal)
            button.setBackgroundImage(UIImage(named: "BlueButton"), forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(12)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            letterContainer.addSubview(button)
            
            // Disable Autoresizing constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            let left: CGFloat = -60.0 + 70.0 * CGFloat(i)
            // Auto Layout Rules
            let leftEdge = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: letterContainer, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: left)
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: letterContainer, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1.0, constant: bottom)
            
            let heightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
            
            let widthConstraint  = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 50)
            
            // add all constraints
            letterContainer.addConstraints([leftEdge, bottomConstraint, heightConstraint, widthConstraint])
        }
    }
    
    func makeVowelButtons() {
        vowelButtons = []
        for i in 1...vowels.count-1 {
            let button: UIButton = UIButton(type: UIButtonType.System)
            button.setTitle(vowels[i], forState: UIControlState.Normal)
            button.setBackgroundImage(UIImage(named: "BlueButton"), forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(12)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            letterContainer.addSubview(button)
            
            // Disable Autoresizing constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            let left: CGFloat = -60.0 + 70.0 * CGFloat(i)
            let bottom: CGFloat = -220
            // Auto Layout Rules
            let leftEdge = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: letterContainer, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: left )
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: letterContainer, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1.0, constant: bottom)
            
            let heightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        
            let widthConstraint  = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 60)
            
            // add all constraints
            letterContainer.addConstraints([leftEdge, bottomConstraint, heightConstraint, widthConstraint])
            
            vowelButtons.append(button)
        }
    }
    
    
    func setupButton() {
        
        button2 = UIButton(type: UIButtonType.System) // .System
        
        button2.setTitle("Animated Layout", forState: UIControlState.Normal)
        
        button2.bounds = CGRect(x: 0, y: 0, width: 300, height: 80)
        // button2.center = CGPoint(x: view.bounds.width / 2, y: 300) // 80 point button, 20 point status bar, 40 point half button, 8 point margins
        
        button2.setBackgroundImage(UIImage(named: "BlueButton"), forState: UIControlState.Normal)
        
        button2.titleLabel?.font = UIFont.systemFontOfSize(17)
        button2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        // Hide button to start
        
        button2.alpha = 0
        
        view.addSubview(button2)
        
        // Disable Autoresizing constraints
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Auto Layout Rules
        let leftEdge = NSLayoutConstraint(item: button2, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 10)
        let rightEdge = NSLayoutConstraint(item: button2, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: -10)
        // add all constraints
        bottomButtonConstraint = NSLayoutConstraint(item: button2, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1.0, constant: 100)
        
        
        view.addConstraints([leftEdge, rightEdge, bottomButtonConstraint])
        
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
