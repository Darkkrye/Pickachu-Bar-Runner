//
//  ViewController.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 22/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    static let spaceKeyCode: UInt16 = 36
    
    var isFirstTime = true
    
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var difficultySegmentedControl: NSSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.usernameTextField.becomeFirstResponder()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func usernameTextFieldAction(_ sender: Any) {
    }
}
