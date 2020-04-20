//
//  SnakeAbility.swift
//  Snake
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

enum Direction: Int {
    case up
    case left
    case down
    case right
    
    func isOpposite(with direction: Direction) -> Bool {
        switch self {
        case .up:
            return direction == .down
        case .left:
            return direction == .right
        case .down:
            return direction == .up
        case.right:
            return direction == .left
        }
    }
}

protocol SnakeAbility {

    init(bounds: GameBounds,  length: Int)
    ///遊戲邊界
    var gameBounds: GameBounds { get }
    ///身體組成 [trail, body, body, ... , head]
    var body: [Point] { get }
    ///長度
    var length: Int { get }
    ///頭位置
    var head: Point { get }
    ///尾巴位置
    var trail: Point { get }
    ///目前方向
    var direction: Direction { get set }
}

extension SnakeAbility {
    var length: Int {
        return body.count
    }
    
    var head: Point {
        guard let point = body.last else { fatalError("Body must not be empty!") }
        return point
    }
    
    var trail: Point {
        guard let point = body.first else { fatalError("Body must not be empty!") }
        return point
    }
}
