//
//  GameViewController.swift
//  Snake
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    typealias SnakeCandidate = SnakeAbility & SnakeAction
    
    struct GameSetting {
        static let `default`: GameSetting = GameSetting(bounds: .default, updateInterval: 0.5)
        ///遊戲格子數，從[0,0]開始
        let bounds: GameBounds
        ///更新間隔(秒數)
        let updateInterval: TimeInterval
    }
    
    enum GameState {
        case ready
        case playing
        case fail
    }
    
    
    @IBOutlet weak var gameView: GameView!
    @IBOutlet weak var gameViewWidthConstraint: GameView!
    @IBOutlet weak var gameViewHeightConstraint: GameView!
    
    let setting: GameSetting = .default
    
    private(set) var state: GameState = .ready
    
    private(set) var snake: SnakeCandidate!

    private(set) var food: Food? = nil

    private var forwardDirection: Direction = .right

    private var timer: Timer? = nil
    
    private var totalTime: TimeInterval = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVariable()
        gameSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if state == .ready {
            gameStart()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if state == .playing {
            gameStop()
        }
    }
    // MARK: - Init
    private func initVariable() {
        let allDirections: [UISwipeGestureRecognizer.Direction] = [.up, .left, .down, .right]
        for direction in allDirections {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(triggerSwipeGesture(_:)))
            swipeGesture.direction = direction
            view.addGestureRecognizer(swipeGesture)
        }
        view.isUserInteractionEnabled = true
    }
    // MARK: - Game function
    private func gameSetup() {
        snake = Snake(bounds: setting.bounds)
        forwardDirection = snake.direction
        gameView.gameBounds = setting.bounds
        gameView.snake = snake
        gameView.food = nil
    
        state = .ready
    }
    
    private func gameStart() {
        gameTimerStart()
        
        state = .playing
    }
    
    private func gameStop() {
        gameTimerStop()
        
        state = .ready
    }
    
    private func gameTimerStart() {
        gameTimerStop()
        
        timer = Timer.scheduledTimer(timeInterval: setting.updateInterval, target: self, selector: #selector(triggerGameTimer), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    private func gameTimerStop() {
        guard let timer = timer else { return }
        timer.invalidate()
        self.timer = nil
    }
    
    @objc private func triggerGameTimer() {
        totalTime += setting.updateInterval

        let result = snake.move(forwardDirection)
        switch result {
        case .success:
            if snake.head == gameView.food?.point {
                snake.grow()
                gameView.food = nil
            }
            else {
                if gameView.food == nil {
                    gameView.food = generateFood()
                }
            }
        case .failure(let error):
            state = .fail
            gameStop()
            switch error {
            case .biteItself:
                showGameOverAlert(reason: "Eat your body!")
            case .collideBounds:
                showGameOverAlert(reason: "Hit the wall!")
            }
        }
        //print("head:", snake.head)
        //print(snake.body.map({ return [$0.x, $0.y]}))
        gameView.setNeedsDisplay()
    }
    
    private func generateFood() -> Food? {
        guard snake.body.count != setting.bounds.width * setting.bounds.height else { return nil }
        var point = Point(x: 0, y: 0)
        let snakeBodyX = snake.body.map({ $0.x })
        let snakeBodyY = snake.body.map({ $0.y })
        
        while snakeBodyX.contains(point.x) {
            point.x = Int.random(in: 0..<setting.bounds.width)
        }
        while snakeBodyY.contains(point.y) {
            point.y = Int.random(in: 0..<setting.bounds.height)
        }
        return Food(point: point)
    }
    
    // MARK: - Others
    @objc private func triggerSwipeGesture(_ gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case .up:
            forwardDirection = .up
        case .left:
            forwardDirection = .left
        case .down:
            forwardDirection = .down
        case .right:
            forwardDirection = .right
        default: break
        }
    }
    
    private func showGameOverAlert(reason: String) {
        let alertVC = UIAlertController(title: "Game Over", message: "\(reason)\nMax length: \(snake.body.count)cm", preferredStyle: .alert)
        let tryAgainButton = UIAlertAction(title: "Try again!", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.gameSetup()
            strongSelf.gameView.setNeedsDisplay()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                strongSelf.gameStart()
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(tryAgainButton)
        alertVC.addAction(cancelButton)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func clickedCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
