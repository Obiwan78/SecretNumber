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
    
    static let BORDER_MARGIN:CGFloat = 15.0
    var _gameRangeToScreenRatio:CGFloat = 1
    
    @IBOutlet weak var ui_gameStatusLabel: UILabel!
    @IBOutlet weak var ui_levelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ui_newGameButton: UIButton!
    @IBOutlet weak var ui_guessedValueField: UITextField!
    @IBOutlet weak var ui_checkButton: UIButton!
    
    @IBOutlet weak var ui_boundaryZone: UIView!
    @IBOutlet weak var ui_lowBoundarieLabel: UILabel!
    @IBOutlet weak var ui_highBoundarieLabel: UILabel!
    
    @IBOutlet weak var cs_boundarieZoneLeading: NSLayoutConstraint!{
        didSet {
            cs_boundarieZoneLeading.constant = ViewController.BORDER_MARGIN
        }
    }
    
    @IBOutlet weak var cs_boundarieZoneTrailing: NSLayoutConstraint! {
        didSet {
        cs_boundarieZoneTrailing.constant = ViewController.BORDER_MARGIN
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        allIsHiddenDisplay()
        ui_boundaryZone.isHidden = true
        updateDisplay()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillLayoutSubviews() {
        let barwidth: CGFloat =  self.view.bounds.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right - 2 * ViewController.BORDER_MARGIN
        _gameRangeToScreenRatio = barwidth / CGFloat(GameController.MAX_VALUE - GameController.MIN_VALUE)
        // MAJ des contraintes avec mode paysage et portrait
        updateDisplay()
        super.viewWillLayoutSubviews() // ne coute rien mais on rappelle la fonction au cas ou si Apple la modifie.
    }
    
    
    @IBAction func ui_NewGameButtonTouched() {
        let levelGame:Int = ui_levelSegmentedControl.selectedSegmentIndex
        print("Boundaries : \(ui_lowBoundarieLabel) / \(ui_highBoundarieLabel)")
        _gameController.startNewGame(withLevel: levelGame)

        updateDisplay()
        
    }
    
    
    @IBAction func ui_checkValueButtonTouched() {
        if let guessText = ui_guessedValueField.text, let gessInt = Int(guessText) {
            _gameController.checkGuessedValue(gessInt)
            ui_guessedValueField.text = "" // pareil = nil 
            updateDisplay()
        }
    }
    
    
    @IBAction func ui_levelSegmentedControl(_ sender: UISegmentedControl) {
        //Uniquement pour l'affichage. Voir GameController.swift.
        let level:Int? = ui_levelSegmentedControl.selectedSegmentIndex
        switch level {
        case 0:
            ui_highBoundarieLabel.text = "100"
            GameController.MAX_VALUE = 100
        case 1:
            ui_highBoundarieLabel.text = "200"
            GameController.MAX_VALUE = 200
        case 2 :
            ui_highBoundarieLabel.text = "500"
            GameController.MAX_VALUE = 500
        default:
            ui_highBoundarieLabel.text = "100"
            GameController.MAX_VALUE = 100
        }
        updateDisplay()
    }
    
    func allIsHiddenDisplay() {
        ui_gameStatusLabel.isHidden = true
        ui_levelSegmentedControl.isHidden = true
        ui_newGameButton.isHidden = true
        ui_boundaryZone.isHidden = true
        ui_guessedValueField.isHidden = true
        ui_checkButton.isHidden = true
    }
    
    
    func updateDisplay() {
        // PARTIE EN COURS :
        if _gameController.isGameInProgress {
            if ui_boundaryZone.isHidden != false { // Si la vue n'était pas encore visible alors ...
                UIView.transition(with: ui_boundaryZone, duration: 0.7, options: [.transitionCurlDown], animations: {
                    self.ui_boundaryZone.isHidden = false
                }, completion: nil)
                ui_newGameButton.isHidden = true
                ui_levelSegmentedControl.isHidden = true
                ui_guessedValueField.isHidden = false
                ui_checkButton.isHidden = false
                ui_gameStatusLabel.isHidden = false
                ui_gameStatusLabel.text = "Essayez de trouver le nombre mystère"
                
                UIView.animate(withDuration: 0.4, animations: { // anime tous les changements de layout
                    self.view.layoutIfNeeded()
                })
            }
            
            // Affichage des valeurs Min et Max / Check
            ui_lowBoundarieLabel.text = String(_gameController.lowBoundary)
            ui_highBoundarieLabel.text = String(_gameController.highBoundary)
            
            // Modifications des constraintes avec les checks
            cs_boundarieZoneLeading.constant = ViewController.BORDER_MARGIN + CGFloat(GameController.MIN_VALUE + _gameController.lowBoundary) * _gameRangeToScreenRatio
            cs_boundarieZoneTrailing.constant = ViewController.BORDER_MARGIN + CGFloat(GameController.MAX_VALUE - _gameController.highBoundary) * _gameRangeToScreenRatio
            
//            print("Bounds width iOS = \(self.view.bounds.width)")
//            print("Bounds width SafeArea = \(self.view.safeAreaInsets.left)\n")
            
            // ANIMATIONS DES VUES :
            UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.40, initialSpringVelocity: 10 ,options: [], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        } else
            
        // PARTIE TERMINE ou DEBUT :
        {
            // Si on est en partie (fin de partie):
            if ui_boundaryZone.isHidden != true {
                UIView.transition(with: ui_boundaryZone, duration: 0.7, options: [.transitionCurlUp], animations: {
                    self.ui_boundaryZone.isHidden = true
                }, completion: nil)
            }
            
            // Sinon c'est qu'on est PLUS EN PARTIE : ui_boundaryZone.isHidden = true
            if _gameController.countCheck >= 1 {
                ui_gameStatusLabel.text = "Bravo, vous avez trouvé en \(_gameController.countCheck) coups"
            } else
            {
                ui_gameStatusLabel.text = "Choississez le Niveau"
            }
            
            // ANIMATIONS DES VUES :
            ui_newGameButton.isHidden = false
            ui_levelSegmentedControl.isHidden = false
            ui_checkButton.isHidden = true
            ui_guessedValueField.isHidden = true
            UIView.animate(withDuration: 0.5, animations: { // anime tous les changements de layout
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
}

