//
//  WelcomeViewController.swift
//  Snake
//
//  Created by cheng-en wu on 4/17/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "showGameViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? GameViewController {
            viewController.modalPresentationStyle = .overFullScreen
            viewController.modalTransitionStyle = .crossDissolve
        }
    }
    
    //MARK: Init
    private func initLayout(){
        startButton.layer.cornerRadius = startButton.frame.size.height / 2
        startButton.layer.borderColor = startButton.currentTitleColor.cgColor
        startButton.layer.borderWidth = 1
    }
    
    @IBAction func clickedStartButton(_ sender: UIButton) {
    }
    
}
