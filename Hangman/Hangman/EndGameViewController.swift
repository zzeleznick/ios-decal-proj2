//
//  EndGameViewController.swift
//  Hangman
//
//  Created by Zach Zeleznick on 3/6/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {
    
    var status: String?
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel?.text = status
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}