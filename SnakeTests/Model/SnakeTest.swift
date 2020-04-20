//
//  SnakeTest.swift
//  SnakeTests
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import XCTest
@testable import Snake

class SnakeTest: XCTestCase {
    let testLength = 4
    let testBounds = GameBounds(width: 10, height: 10)
    
    lazy var testSnake: SnakeAbility&SnakeAction = Snake(bounds: testBounds, length: testLength)
    //[0, 0] [1, 0] [2, 0] [3, 0]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() {
        XCTAssert(testSnake.body.count == testLength)
    }

    func testTurnUp() {
        testSnake.move(.down)
        testSnake.move(.right)
        
        let headBeforMovement = testSnake.head
        
        testSnake.move(.up)
        
        XCTAssert(testSnake.body.count == testLength)
        XCTAssert(testSnake.direction == .up)
        XCTAssert(testSnake.head == headBeforMovement.move(.up))
    }
    
    func testTurnLeft() {
        let headBeforMovement = testSnake.head

        testSnake.move(.left)

        XCTAssert(testSnake.body.count == testLength)
        XCTAssert(testSnake.direction == .right)
        XCTAssert(testSnake.head == headBeforMovement.move(.right))
    }

    func testTurnDown() {
        let headBeforMovement = testSnake.head

        testSnake.move(.down)
        
        XCTAssert(testSnake.body.count == testLength)
        XCTAssert(testSnake.direction == .down)
        XCTAssert(testSnake.head == headBeforMovement.move(.down))
    }

    func testTurnRight() {
        let headBeforMovement = testSnake.head

        testSnake.move(.right)
        
        XCTAssert(testSnake.body.count == testLength)
        XCTAssert(testSnake.direction == .right)
        XCTAssert(testSnake.head == headBeforMovement.move(.right))
    }

    func testMoveCurrentDirection() {
        let beforeMovementBody = testSnake.body
        let beforeMovementDirection = testSnake.direction
        let beforeMovementHead = testSnake.head
        
        testSnake.move()
        
        XCTAssert(testSnake.body.count == beforeMovementBody.count)
        XCTAssert(testSnake.direction == beforeMovementDirection)
        XCTAssert(testSnake.head == beforeMovementHead.move(beforeMovementDirection))
    }
    
    func testBiteItself() {
        testSnake.move(.down)

        testSnake.move(.left)

        switch testSnake.move(.up) {
        case .success:
            XCTFail("This case should be fail!")
        case .failure(let error):
            XCTAssert(error == .biteItself)
        }
    }
    
    func testHitThwWall() {
        let result = testSnake.move(.up)
        switch result {
        case .success:
            XCTFail("This case should be fail!")
        case .failure(let error):
            XCTAssert(error == .collideBounds)
        }
    }
    
    func testGrow() {
        let lengthBeforeGrow = testSnake.length
        let trailBeforeGrow = testSnake.trail
        
        testSnake.grow()
        testSnake.move()
        
        XCTAssert(testSnake.length == lengthBeforeGrow + 1)
        XCTAssert(testSnake.trail == trailBeforeGrow)
    }
    
}
