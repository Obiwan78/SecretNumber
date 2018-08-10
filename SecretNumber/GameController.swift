//
//  GameController.swift
//  SecretNumber
//
//  Created by Alban BERNARD on 02/08/2018.
//  Copyright © 2018 Alban BERNARD. All rights reserved.
//

import Foundation


class GameController {

    static let MIN_VALUE:Int = 0
    static var MAX_VALUE:Int = 100

    private var _lowBoundary: Int = GameController.MIN_VALUE
    private var _highBoundary: Int = GameController.MAX_VALUE

    private var _secretNumber: Int?
    private var _lastGuessedValue: Int?
    
    var countCheck:Int = 0
    
    var lowBoundary: Int {
        return _lowBoundary
    }

    var highBoundary: Int {
        return _highBoundary
    }
    
    var secretNumber: Int? {
        return _secretNumber
    }
    
    var isGameInProgress: Bool { // partie en cours si _secretNumber n'a pas été généré et si l'utilisateur n'a pas entré de nombre _lastGuessedValue
        guard let secretNumber = _secretNumber else { return false }
//        return true
        return _lastGuessedValue == nil || _lastGuessedValue! != secretNumber //return true
    }
    
    
    //-------------------------------------------------
    // FONCTIONS
    //-------------------------------------------------
    
    func startNewGame(withLevel level:Int?=1, withSecretNumber secretNumber: Int? = nil) {
        countCheck = 0
        _lowBoundary = 0
        switch level {
            case 0: _highBoundary = 100
                    GameController.MAX_VALUE = 100
            case 1: _highBoundary = 500
                    GameController.MAX_VALUE = 500
            case 2: _highBoundary = 1000
                    GameController.MAX_VALUE = 1000
            default: _highBoundary = 100
                GameController.MAX_VALUE = 100
        }
        print("----------------\nNew Game with level \(String(describing: level)),\n lowBoundary = \(_lowBoundary), MIN_VALUE = \(GameController.MIN_VALUE),\n highBoundary = \(_highBoundary), MAX_VALUE = \(GameController.MAX_VALUE)\n")
        
        if secretNumber != nil {
            _secretNumber = secretNumber
        } else {
            _secretNumber = Int(withRandomNumberBetween: lowBoundary, and: highBoundary)
            print("Le nombre mistère est \(String(describing: _secretNumber))\n----------------\n")
        }
        
    }
    
    func checkGuessedValue(_ value: Int) {
        guard let secretNumber = _secretNumber else { return }
//        self.secretNumber // le secretNumber de var ligne 32
        _lastGuessedValue = value
        countCheck = countCheck + 1
        if secretNumber != value {
            if value < secretNumber {
                _lowBoundary = max(_lowBoundary, value)
                print("c'est plut haut")
            } else { // value > secretNumber
                _highBoundary = min(_highBoundary, value)
                print("C'est plus bas")
            }
        } else {
            print("Bravo vous avez trouver en \(countCheck) coups.")
            // Il faut enlever le clavier qui reste apparent.

        }
        
    }
    
}
