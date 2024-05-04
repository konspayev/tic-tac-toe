//
//  ViewController.swift
//  Task
//
//  Created by astanahub on 20.04.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var winLabel: UILabel!
    
    @IBOutlet var arrayButton: [UIButton]!
    
    lazy var game = TicTacToe(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click1(_ sender: UIButton) {
        guard let index = arrayButton.firstIndex(of: sender) else { return }
        game.choiceXO(for: index)
        self.updateView()
        self.game.computerTurn()
    }
    
    private func updateView() {
        for i in arrayButton.indices {
            let button = arrayButton[i]
            let XO = game.arrayXO[i]
            if let label = XO.label {
                button.setTitle(label, for: .normal)
                button.isEnabled = false
            } else {
                button.setTitle("", for: .normal)
                button.isEnabled = true
            }
        }
        
        if let win = game.win() {
            winLabel.text = "Winner: \(win)"
            for i in arrayButton {
                i.isEnabled = false
            }
        }
    }
    
    
    @IBAction func restart(_ sender: UIButton) {
        for i in arrayButton.indices {
            let button = arrayButton[i]
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
        winLabel.text = ""
        game.restart()
        updateView()
    }

    
}


