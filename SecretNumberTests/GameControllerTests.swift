//
//  GameControllerTests.swift
//  GameControllerTests
//
//  Created by Alban BERNARD on 02/08/2018.
//  Copyright © 2018 Alban BERNARD. All rights reserved.
//

import XCTest
@testable import SecretNumber

class GameControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGameStatus() { //test est obligatoire devant le nom
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let gameController = GameController()
        XCTAssertFalse(gameController.isGameInProgress)
        gameController.startNewGame(withSecretNumber: 40)
        XCTAssertTrue(gameController.isGameInProgress)
        gameController.checkGuessedValue(20)
        XCTAssertTrue(gameController.isGameInProgress)
        gameController.checkGuessedValue(80)
        XCTAssertTrue(gameController.isGameInProgress)
        gameController.checkGuessedValue(40)
        XCTAssertFalse(gameController.isGameInProgress)
    }
    
    func testBoundaries() {
        let gameController = GameController()
        
        gameController.startNewGame(withSecretNumber: 55)
        XCTAssertEqual(GameController.MIN_VALUE, gameController.lowBoundary)
        XCTAssertEqual(GameController.MAX_VALUE, gameController.highBoundary)
        
        gameController.checkGuessedValue(30)
        XCTAssertEqual(30, gameController.lowBoundary)
        XCTAssertEqual(GameController.MAX_VALUE, gameController.highBoundary)
        
        gameController.checkGuessedValue(75)
        XCTAssertEqual(30, gameController.lowBoundary)
        XCTAssertEqual(75, gameController.highBoundary)
        
        gameController.checkGuessedValue(45)
        XCTAssertEqual(45, gameController.lowBoundary)
        XCTAssertEqual(75, gameController.highBoundary)
        
        gameController.checkGuessedValue(60)
        XCTAssertEqual(45, gameController.lowBoundary)
        XCTAssertEqual(60, gameController.highBoundary)
    }
    
    
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
