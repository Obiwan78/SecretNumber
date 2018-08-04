//
//  ViewController.swift
//  SecretNumber
//
//  Created by Alban BERNARD on 02/08/2018.
//  Copyright © 2018 Alban BERNARD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let _gameController = GameController()
    @IBOutlet weak var ui_guessedValueField: UITextField!
    @IBOutlet weak var ui_gameStatusLabel: UILabel!
    @IBOutlet weak var ui_checkButton: UIButton!
    @IBOutlet weak var BoundariesView: UIView!
    @IBOutlet weak var ui_lowBoundarieLabel: UILabel!
    @IBOutlet weak var ui_highBoundarieLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_guessedValueField.isHidden = true
        ui_gameStatusLabel.isHidden = true
        BoundariesView.isHidden = true
        ui_highBoundarieLabel.isHidden = true
        ui_lowBoundarieLabel.isHidden = true
        updateDisplay()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ui_NewGameButtonTouched() {
        _gameController.startNewGame()
//        ui_guessedValueField.isHidden = false
//        ui_gameStatusLabel.isHidden = false
//        checkButton.isHidden = false
        updateDisplay()
    }

    @IBAction func ui_checkValueButtonTouched() {
        if let guessText = ui_guessedValueField.text, let gessInt = Int(guessText) {
            _gameController.checkGuessedValue(gessInt)
            updateDisplay()
        }
    }
    
    func updateDisplay() {
        if _gameController.isGameInProgress {
            ui_guessedValueField.isHidden = false
            ui_checkButton.isHidden = false
            ui_gameStatusLabel.isHidden = false
            ui_gameStatusLabel.text = "Essayez de trouver le nombre mystère"
            BoundariesView.isHidden = false
            ui_highBoundarieLabel.isHidden = false
            ui_lowBoundarieLabel.isHidden = false
            ui_lowBoundarieLabel.text = String(_gameController.lowBoundary)
            ui_highBoundarieLabel.text = String(_gameController.highBoundary)
        } else {
            ui_gameStatusLabel.text = nil
            ui_checkButton.isHidden = true
        }
    }
    
    
}

