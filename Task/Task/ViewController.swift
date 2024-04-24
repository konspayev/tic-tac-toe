//
//  ViewController.swift
//  Task
//
//  Created by astanahub on 20.04.2024.
//

import UIKit

class ViewController: UIViewController {

    let game = TicTacToe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func click1(_ sender: UIButton) {
        guard let index = arrayButton.firstIndex(of: sender) else {
            return
        }
        game.choiceXO(for: index)
        updateView()
    }
    
    func updateView() {
        for i in arrayButton.indices {
            let button = arrayButton[i]
            let XO = game.arrayXO[i]
            if let label = XO.label {
                button.setTitle(label, for: .normal)
                button.isEnabled = false
            }
        }
        if let win = game.win() {
            winLabel.text = "Winner \(win)"
            for i in arrayButton {
                i.isEnabled = false
            }
        }
    }
    
    @IBOutlet var winLabel: UILabel!
    @IBOutlet var arrayButton: [UIButton]!
    @IBAction func restart(_ sender: UIButton) {
        for i in arrayButton.indices {
            let button = arrayButton[i]
            button.setTitle("", for: .normal)
            button.isEnabled = false
        }
        winLabel.text = ""
        game.restart()
    }

    
}


