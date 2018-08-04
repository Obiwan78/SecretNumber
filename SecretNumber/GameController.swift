//
//  GameController.swift
//  SecretNumber
//
//  Created by Alban BERNARD on 02/08/2018.
//  Copyright © 2018 Alban BERNARD. All rights reserved.
//

import Foundation


class GameController {

    static let MIN_VALUE = 0
    static let MAX_VALUE = 100
    private var _secretNumber: Int?
    private var _lastGuessedValue: Int?
    private var _lowBoundary: Int = GameController.MIN_VALUE
    private var _highBoundary: Int = GameController.MAX_VALUE

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
    
    func startNewGame(withSecretNumber secretNumber: Int? = nil) {
        if secretNumber != nil {
            _secretNumber = secretNumber
        } else {
//            _secretNumber = 50
            _lastGuessedValue = 10
            let minSecretNumber = lowBoundary
            let maxSecretNumber = highBoundary
            _secretNumber = minSecretNumber + Int(arc4random_uniform(UInt32(maxSecretNumber-minSecretNumber)))
            print("le nombre mistère est \(String(describing: _secretNumber))")
        }
        
    }
    
    func checkGuessedValue(_ value: Int) {
        guard let secretNumber = _secretNumber else { return }
//        self.secretNumber // le secretNumber de var ligne 28
        _lastGuessedValue = value
        
        if secretNumber != value {

            if value < secretNumber {
                _lowBoundary = max(_lowBoundary, value)
                print("c'est plut haut")
            } else { // value > secretNumber
                _highBoundary = min(_highBoundary, value)
                print("C'est plus bas")
            }
        } else {
            print("Bravo")
        }
        
    }
    
}
