//
//  Snake.swift
//  Snake
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class Snake: SnakeAbility, SnakeAction{
    var gameBounds: GameBounds
    
    var body: [Point] = []

    var direction: Direction = .right
    
    required init(bounds: GameBounds = .default, length: Int = 2) {
        self.gameBounds = bounds
        
        for i in 0..<length{
            body.append(Point(x: i, y: 0))
        }
    }
    
    func grow() {
        let nextPoint = trail
        body.insert(nextPoint, at: 0)
    }
    
    func canMove(to point: Point) -> Result<Void, MovementError> {
        guard point.x >= 0, point.y >= 0 else {
            return .failure(.collideBounds)
        }
        guard point.x < gameBounds.width, point.y < gameBounds.height else {
            return .failure(.collideBounds)
        }
        guard !body.contains(point) else {
            return .failure(.biteItself)
        }
        return .success(())
    }
    
    func move(_ toDirection: Direction? = nil) -> Result<Void, MovementError>{
        var toDirection: Direction = toDirection ?? self.direction
        
        //如果是相反，則將前進方向改為現在方向
        if direction.isOpposite(with: toDirection) {
            toDirection = self.direction
        }
        
        let nextPoint = head.move(toDirection)
        let result = canMove(to: nextPoint)
        
        switch result {
        case .success:
            body.removeFirst()
            body.append(nextPoint)
            self.direction = toDirection
        case .failure(let error):
            print(error)
        }
        return result
    }
}
