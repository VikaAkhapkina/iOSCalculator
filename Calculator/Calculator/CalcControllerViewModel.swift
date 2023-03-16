//
//  CalcControllerViewModel.swift
//  Calculator
//
//  Created by Viktoriya on 13.02.23.
//

import UIKit

enum CurrentNumber {
    case firstNumber
    case secondNumber
}

class CalcControllerViewModel {
    
    //MARK: - TableView DataSourse Array
    
    let calcButtonCells: [CalculatorButton] = [
        .allClear, .plusMines, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
        
    ]
    //MARK: - Variables
    private(set) lazy var calcHeaderLabel: String = "42"
    private(set) var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: Int? = nil
    private(set) var secondNumber: Int? = nil
}

extension CalcControllerViewModel {
    
    public func didSelectButton(with calcButton: CalculatorButton){
        switch calcButton {
        case .allClear:
            fatalError()
        case .plusMines:
            fatalError()
        case .percentage:
            fatalError()
        case .divide:
            fatalError()
        case .multiply:
            fatalError()
        case .subtract:
            fatalError()
        case .add:
            fatalError()
        case .equals:
            fatalError()
        case .number(let int):
            fatalError()
        case .decimal:
            fatalError()
        }
    }
}


extension CalcControllerViewModel {
    
    private func didSelectButton(with number: Int) {
        
        if self.currentNumber == .firstNumber {
            
            if let firstNumber = self.firstNumber {
                var firstNimberString = firstNumber.description
                firstNimberString.append(number.description)
                self.firstNumber = Int(firstNimberString)
            }
            
        } else {
            self.firstNumber = Int(number)
        }
        
    }
}
 
