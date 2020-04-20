//
//  SnakeAction.swift
//  Snake
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import Foundation

enum MovementError: Error{
    ///咬到自己
    case biteItself
    ///碰到邊界
    case collideBounds
}

protocol SnakeAction {
    func grow()
    
    @discardableResult
    func move(_ toDirection: Direction?) -> Result<Void, MovementError>
}

extension SnakeAction {
    func move(_ toDirection: Direction? = nil) -> Result<Void, MovementError>{
        return move(toDirection)
    }
}
