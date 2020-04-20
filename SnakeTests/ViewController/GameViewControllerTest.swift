//
//  GameViewControllerTest.swift
//  SnakeTests
//
//  Created by cheng-en wu on 4/20/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import XCTest
@testable import Snake

class GameViewControllerTest: XCTestCase {
    lazy var testViewController: GameViewController? = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GameViewController")
        viewController.loadViewIfNeeded()
        return viewController as? GameViewController
    }()

    
    func testInit() {
        XCTAssertNotNil(testViewController)
        XCTAssertNotNil(testViewController?.gameView)
        XCTAssert(testViewController?.state == .ready)
    }
    
    func testGameStartWhenViewDidAppear() {
        testViewController!.viewDidAppear(true)
        
        XCTAssertNotNil(testViewController?.snake)
        XCTAssert(testViewController?.state == .playing)
    }
    
    func testGameStopWhenViewWillDisappear() {
        testViewController!.viewDidAppear(true)
        testViewController!.viewWillDisappear(true)
        
        XCTAssert(testViewController?.state == .ready)
    }
    
    func testGeneratedFood() {
        testViewController!.viewDidAppear(true)
        
        let exp = expectation(description: "Test after 1 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 1)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(testViewController?.food)
        } else {
            XCTFail("Delay interrupted")
        }
    }

}
