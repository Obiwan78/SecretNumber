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
//    private var  MIN_VALUE = 0
//    private var  MAX_VALUE = 100
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
    
    func startNewGame(withLevel level:Int?=1, withSecretNumber secretNumber: Int? = nil) {
        _lowBoundary = 0
        countCheck = 0
        print("New Game with level \(String(describing: level))")
        switch level {
            case 0:  _highBoundary = 100
            case 1:  _highBoundary = 200
            case 2:  _highBoundary = 500
            default: _highBoundary = 100
        }
        
        if secretNumber != nil {
            _secretNumber = secretNumber
        } else {
            let minSecretNumber = lowBoundary
            let maxSecretNumber = highBoundary
            _secretNumber = minSecretNumber + Int(arc4random_uniform(UInt32(maxSecretNumber-minSecretNumber)))
            print("le nombre mistère est \(String(describing: _secretNumber))")
        }
        
    }
    
    func checkGuessedValue(_ value: Int) {
        guard let secretNumber = _secretNumber else { return }
//        self.secretNumber // le secretNumber de var ligne 32
        _lastGuessedValue = value
        
        if secretNumber != value {
            countCheck = countCheck + 1
            if value < secretNumber {
                _lowBoundary = max(_lowBoundary, value)
                print("c'est plut haut")
            } else { // value > secretNumber
                _highBoundary = min(_highBoundary, value)
                print("C'est plus bas")
            }
        } else {
            print("Bravo vous avez trouver en \(countCheck) coups.")
        }
        
    }
    
}
