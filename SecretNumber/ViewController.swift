//
//  ViewController.swift
//  SecretNumber
//
//  Created by Alban BERNARD on 02/08/2018.
//  Copyright © 2018 Alban BERNARD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let _gameController = GameController()
    var barwidth: CGFloat = 0

    var _count = 0
    var _timer = Timer()
    
    var _gameRangeToScreenRatio:CGFloat = 1
    @IBOutlet weak var ui_principalView: UIView!
    
    @IBOutlet weak var ui_firstVerticalStackView: UIStackView!
    @IBOutlet weak var ui_gameStatusLabel: UILabel!
    @IBOutlet weak var ui_levelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ui_newGameButton: UIButton!
    @IBOutlet weak var ui_counterLabel: UILabel!
    @IBOutlet weak var ui_checkAndVerifyView: UIView!
    @IBOutlet weak var ui_guessedValueField: UITextField!
    @IBOutlet weak var ui_checkButton: UIButton!
    
    @IBOutlet weak var ui_boundaryPrincipalView: UIView!
    @IBOutlet weak var ui_boundaryBarView: UIView!
    @IBOutlet weak var ui_lowBoundarieLabel: UILabel!
    @IBOutlet weak var ui_highBoundarieLabel: UILabel!
    @IBOutlet weak var cs_boundarieZoneLeading: NSLayoutConstraint!
    @IBOutlet weak var cs_boundarieZoneTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var ui_resultView: UIView!
    @IBOutlet weak var ui_checksLabel: UILabel!
    @IBOutlet weak var ui_timeLabel: UILabel!
    
    
//    let gameStatusLabelText : String = "Essayez de retrouver le nombre mystère"//"Try to find the Mysterious Number"
////    let gameStatusLabelText : String = NSLocalizedString("Retrouver le nombre mystère", comment: "Find the Mysterious Number")
//    let chooseTheLevelText : String = "Choisissez le niveau de difficulté entre :"//"Choose the level between :"
//    let firstPartText : String = "Bravo vous avez trouvez en "//"Great, You find it in "
//    let secondPartText : String = " coups en "//" checks in "
    //-------------------------------------------------
    // Override
    //-------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
//        allIsHiddenDisplay()
        ui_boundaryPrincipalView.isHidden = true
        ui_counterLabel.isHidden = true
        ui_resultView.isHidden = true
        updateDisplay()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //-------------------------------------------------
    // Redimensionnement des vues en portrait et paysage
    // pour redim automatique.
    //-------------------------------------------------

    override func viewDidLayoutSubviews() { // on utilisait viewWillLayoutSubviews()
        barwidth = self.ui_boundaryPrincipalView.bounds.width
        _gameRangeToScreenRatio = barwidth / CGFloat(GameController.MAX_VALUE - GameController.MIN_VALUE)
        // MAJ des contraintes avec mode paysage et portrait
        updateDisplay()
        super.viewDidLayoutSubviews() // ne coute rien mais on rappelle la fonction au cas ou si Apple la modifie.
    }

    override func viewWillLayoutSubviews() {
        barwidth = self.ui_boundaryPrincipalView.bounds.width
        _gameRangeToScreenRatio = barwidth / CGFloat(GameController.MAX_VALUE - GameController.MIN_VALUE)
        // MAJ des contraintes avec mode paysage et portrait
        updateDisplay()
        super.viewWillLayoutSubviews() // ne coute rien mais on rappelle la fonction au cas ou si Apple la modifie.
    }
 
    //-------------------------------------------------
    // Hide / Close keyboard after typing in uitextfield
    //https://blog.apoorvmote.com/hide-close-keyboard-after-typing-in-textfield/
    //-------------------------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ui_guessedValueField.resignFirstResponder()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    //-------------------------------------------------
    // IBACTIONS
    //-------------------------------------------------

    @IBAction func ui_NewGameButtonTouched() {
        let levelGame:Int = ui_levelSegmentedControl.selectedSegmentIndex
        _count = 0
        _gameController.startNewGame(withLevel: levelGame)
        _timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        updateDisplay()
    }
    
    
    @IBAction func ui_checkValueButtonTouched() {
        if let guessText = ui_guessedValueField.text, let gessInt = Int(guessText) {
            _gameController.checkGuessedValue(gessInt)
            ui_guessedValueField.text = "" // pareil que nil
            updateDisplay()
        }
    }
    
    
    @IBAction func ui_levelSegmentedControl(_ sender: UISegmentedControl) {
                let level:Int? = ui_levelSegmentedControl.selectedSegmentIndex
        switch level {
        case 0:
            ui_highBoundarieLabel.text = "100"
            GameController.MAX_VALUE = 100
        case 1:
            ui_highBoundarieLabel.text = "500"
            GameController.MAX_VALUE = 500
        case 2 :
            ui_highBoundarieLabel.text = "1000"
            GameController.MAX_VALUE = 1000
        default:
            ui_highBoundarieLabel.text = "100"
            GameController.MAX_VALUE = 100
        }
        updateDisplay()
    }
    
    
    //-------------------------------------------------
    // FONCTIONS
    //-------------------------------------------------

    func updateDisplay() {
        // PARTIE EN COURS :
        if _gameController.isGameInProgress == true {
            if ui_boundaryPrincipalView.isHidden != false { // Si la vue n'était pas encore visible alors ...
                UIView.transition(with: ui_boundaryPrincipalView, duration: 0.7, options: [.transitionCurlDown], animations: {
                    self.ui_boundaryPrincipalView.isHidden = false
                }, completion: nil)
                ui_gameStatusLabel.isHidden = true
                ui_levelSegmentedControl.isHidden = true
                ui_resultView.isHidden = true
                ui_newGameButton.isHidden = true
                ui_checkAndVerifyView.isHidden = false
//                ui_guessedValueField.isHidden = false
//                ui_checkButton.isHidden = false
                ui_counterLabel.isHidden = false
                UIView.animate(withDuration: 0.4, animations: { // anime tous les changements de layout
                    self.view.layoutIfNeeded()
                })
            }
            
            // Affichage des valeurs Min et Max / Check
            ui_lowBoundarieLabel.text = String(_gameController.lowBoundary)
            ui_highBoundarieLabel.text = String(_gameController.highBoundary)
            
            // Modifications des constraintes avec les checks. On ajoutait ViewController.BORDER_MARGIN + ...
            cs_boundarieZoneLeading.constant = CGFloat(GameController.MIN_VALUE + _gameController.lowBoundary) * _gameRangeToScreenRatio
            cs_boundarieZoneTrailing.constant = CGFloat(GameController.MAX_VALUE - _gameController.highBoundary) * _gameRangeToScreenRatio
            
//            print("Bounds width iOS = \(self.view.bounds.width)")
//            print("Bounds width SafeArea = \(self.view.safeAreaInsets.left)\n")
            
            // ANIMATIONS DES VUES :
            UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.40, initialSpringVelocity: 10 ,options: [], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        } else
            
        // PARTIE TERMINE ou DEBUT : _gameController.isGameInProgress == false
        {
            // on cache ui_boundaryPrincipalView (aide barre horizontale) et la vue Resultat:
            if ui_boundaryPrincipalView.isHidden != true { // = visible
                UIView.transition(with: ui_boundaryPrincipalView, duration: 0.7, options: [.transitionCurlUp], animations: {
                    self.ui_boundaryPrincipalView.isHidden = true

                }, completion: nil)
            }
            
            if _gameController.countCheck >= 1 {
                ui_resultView.isHidden = false
                ui_gameStatusLabel.isHidden = false // Choose the level between :
                ui_counterLabel.isHidden = true //chronometer
                ui_checksLabel.text = "\(_gameController.countCheck)"
                ui_timeLabel.text = "\(_count)"
                _timer.invalidate()
            } else
            {
                ui_counterLabel.isHidden = true
                ui_gameStatusLabel.isHidden = false
            }
            
            // ANIMATIONS DES VUES :
//            ui_gameStatusLabel.isHidden = false
            ui_levelSegmentedControl.isHidden = false
            ui_newGameButton.isHidden = false
            ui_checkAndVerifyView.isHidden = true
//            ui_checkButton.isHidden = true
//            ui_guessedValueField.isHidden = true
            UIView.animate(withDuration: 0.7, animations: { // anime tous les changements de layout
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func counter() {
        _count += 1
        ui_counterLabel.text = "\(_count)"
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}

