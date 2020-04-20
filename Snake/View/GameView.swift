//
//  GameView.swift
//  Snake
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class GameView: UIView {
    typealias SnakeCandidate = SnakeAbility & SnakeAction

    var snake: SnakeCandidate? = nil
    var gameBounds: GameBounds? = nil
    var food: Food? = nil
    
    private var borderWidth: CGFloat = 5
    private var gameFrame: CGRect = .zero
    private var gridSize: CGSize = .zero

    private var borderPath: UIBezierPath? = nil
    private var gameBoundsPath: UIBezierPath? = nil
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard prepareForDraw() else { return }
        
        drawBorder()
        
        drawGameBound()
        
        drawSnake()
        
        drawFood()
    }
    
    private func prepareForDraw() -> Bool {
        guard let gameBounds = gameBounds, let _ = snake else { return false }

        gameFrame = bounds.insetBy(dx: borderWidth, dy: borderWidth)
        gridSize.width = gameFrame.width / CGFloat(gameBounds.width)
        gridSize.height = gameFrame.height / CGFloat(gameBounds.height)
        return true
    }
    
    private func drawBorder() {
        let path = UIBezierPath(rect: bounds)
        UIColor.red.setFill()
        path.fill()
        
        borderPath = path
    }

    private func drawGameBound() {
        let path = UIBezierPath(rect: gameFrame)
        UIColor.white.setFill()
        path.fill()
        gameBoundsPath = path
    }

    private func drawSnake() {
        guard let gameBounds = gameBoundsPath?.bounds else { return }
        guard let snake = snake else { return }
                
        for index in 0..<snake.body.count {
            //在lldb debug時候，point名稱會跟 func point(inside: CGPoint, with: UIEvent) 衝突到，導致breakpoint與po無法找到對應的變數point，故改成_point
            let _point = snake.body[index]
            let bodyOrigin = CGPoint(x: gridSize.width * CGFloat(_point.x),
                                     y: gridSize.height * CGFloat(_point.y))
            
            var bodyFrame = CGRect(origin: bodyOrigin, size: gridSize)
            bodyFrame = bodyFrame.offsetBy(dx: gameBounds.origin.x, dy: gameBounds.origin.y)

            let path = UIBezierPath(rect: bodyFrame)
            UIColor.brown.setFill()
            path.fill()
        }
    }
    
    private func drawFood() {
        guard let food = food else { return }
        guard let gameBounds = gameBoundsPath?.bounds else { return }

        var foodOrigin = CGPoint(x: gridSize.width * CGFloat(food.point.x) + gridSize.width / 2,
                                 y: gridSize.height * CGFloat(food.point.y) + gridSize.height / 2)
        foodOrigin.x += gameBounds.origin.x
        foodOrigin.y += gameBounds.origin.y
        
        let path = UIBezierPath(arcCenter: foodOrigin, radius: gridSize.width / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        UIColor.green.setFill()
        path.fill()
    }
    
}
