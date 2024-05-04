//
//  TicTacToe.swift
//  Task
//
//  Created by Nursultan Konspayev on 22.04.2024.
//

import Foundation
import UIKit

class TicTacToe {
    var arrayXO: [XO] = []
    var isComputer = false
    var isComputerTurn = false
    var counter = 0
    weak var viewController: ViewController?
    let winCombination = [
        [0,1,2], 
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    
    init(_ viewController: ViewController) {
        self.viewController = viewController
        for _ in 0...8 {
            let XO = XO()
            arrayXO.append(XO)
        }
    }
    
    func choiceXO(for index: Int) {
        counter += 1
        if isComputer {
            if counter % 2 != 0 {
                arrayXO[index].label = "❌"
                isComputerTurn = true
            } else {
                arrayXO[index].label = "⭕️"
                isComputerTurn = false
            }
        } else {
            if counter % 2 != 0 {
                arrayXO[index].label = "❌"
            } else {
                arrayXO[index].label = "⭕️"
            }
        }
    }
    
    func win() -> String? {
        for i in winCombination {
            if arrayXO[i[0]].label == arrayXO[i[1]].label && 
                arrayXO[i[1]].label == arrayXO[i[2]].label &&
                arrayXO[i[0]].label != nil {
                return arrayXO[i[0]].label
            }
        }
        if counter == 9 {
            return "Draw"
        }
        return nil
    }
    
    func computerTurn() {
        if isComputerTurn {
            let enabledButtons = viewController?.arrayButton.compactMap { button in
                if button.isEnabled == true {
                    return button
                }
                return nil
            }
            guard enabledButtons?.isEmpty == false else { return }
            var click: UIButton?
            
            for check in [checkEmptySide, checkEmptyCorner, checkCenter, blockUserWin, findComputer] {
                if let button = check() {
                    click = button
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                guard let button = click else { return }
                self.viewController?.click1(button)
                self.viewController?.click1(enabledButtons![Int.random(in: 0...enabledButtons!.count-1)])
            }
        }
    }
    
    func restart() {
        for i in arrayXO.indices {
            arrayXO[i].label = nil
        }
        counter = 0
    }
    
    func checkEmptySide() -> UIButton? {
        let sides = [1, 3, 5, 7]
        
        let emptySides = sides.filter { side in
            self.viewController?.arrayButton[side].title(for: .normal) == ""
        }
        
        if !emptySides.isEmpty {
            let randomSide = emptySides.randomElement()!
            return self.viewController?.arrayButton[randomSide]
        }
        return nil
    }
    
    func checkEmptyCorner() -> UIButton? {
        let corners = [0, 2, 6, 8]
        let emptyCorners = corners.filter { corner in
            self.viewController?.arrayButton[corner].title(for: .normal) == ""
        }
        if !emptyCorners.isEmpty {
            let randomCorner = emptyCorners.randomElement()!
            return self.viewController?.arrayButton[randomCorner]
        }
        return nil
    }
    
    func checkCenter() -> UIButton? {
        if self.viewController?.arrayButton[4].title(for: .normal) == "" {
            return self.viewController?.arrayButton[4]
        }
        return nil
    }
    
    func blockUserWin() -> UIButton? {
        for combination in winCombination {
            let positions = combination.map { self.viewController?.arrayButton[$0].title(for: .normal) }
            let userSymbolCount = positions.filter { $0 == "❌" }.count
            let emptyCellIndex = positions.firstIndex(of: "")
            
            if userSymbolCount == 2 && emptyCellIndex != nil {
                return self.viewController?.arrayButton[combination[emptyCellIndex!]]
            }
        }
        return nil
    }
    
    func findComputer() -> UIButton? {
        for combination in winCombination {
            let positions = combination.map { self.viewController?.arrayButton[$0].title(for: .normal) }
            let computerSymbolCount = positions.filter { $0 == "⭕️" }.count
            let emptyCellIndex = positions.firstIndex(of: "")
            
            if computerSymbolCount == 2 && emptyCellIndex != nil {
                return self.viewController?.arrayButton[combination[emptyCellIndex!]]
            }
        }
        return nil
    }
    
}
