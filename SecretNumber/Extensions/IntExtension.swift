//
//  IntExtension.swift
//  SecretNumber
//
//  Created by Alban BERNARD on 08/08/2018.
//  Copyright © 2018 Alban BERNARD. All rights reserved.
//

import Foundation

extension Int {
    init(withRandomNumberBetween minValue:Int, and maxValue:Int) {
        self = minValue + Int(arc4random_uniform(UInt32(maxValue+minValue+1))) //+1 car la fonction arc4random renvoi un nombre entre 0 et MaxValue EXCLU
    }
}

