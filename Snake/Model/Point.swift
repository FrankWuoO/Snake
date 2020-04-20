//
//  Point.swift
//  Snake
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import Foundation
import struct CoreGraphics.CGPoint

struct Point {
    var x: Int
    var y: Int
    
    func move(_ direction: Direction) -> Point {
        switch direction {
        case .up:
            return Point(x: x, y: y - 1)
        case .left:
            return Point(x: x - 1, y: y)
        case .down:
            return Point(x: x, y: y + 1)
        case.right:
            return Point(x: x + 1, y: y)
        }
    }
}

extension Point: Equatable {
    static func == (lhs: Point, rhs: Point) -> Bool{
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
