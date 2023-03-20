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
    
    var updateView: (() -> Void)? 
    
    //MARK: - TableView DataSourse Array
    let calcButtonCells: [CalculatorButton] = [
        .allClear, .plusMines, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
        
    ]
    //MARK: - Normal Variables
    private(set) lazy var calcHeaderLabel: String = (self.firstNumber ?? 0).description 
    private(set) var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: Int? = nil
    private(set) var secondNumber: Int? = nil
    
    //MARK: - Memory Variables
    private(set) var prevNumber: Int? = nil
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
        case .number(let number):
            self.didSelectNumber(with: number)
        case .decimal:
            fatalError()
        }
        
        self.updateView?()
    }
}


extension CalcControllerViewModel {
    
    private func didSelectNumber(with number: Int) {
        
        if self.currentNumber == .firstNumber {
            
            if let firstNumber = self.firstNumber {
                var firstNumberString = firstNumber.description
                firstNumberString.append(number.description)
                self.firstNumber = Int(firstNumberString)
                self.prevNumber = Int(firstNumberString)
                
            } else {
                self.firstNumber = Int(number)
                self.prevNumber = Int(number)
            }
            
        } else {

            if let secondNumber = self.secondNumber {
                
                var secondNumberString = secondNumber.description
                secondNumberString.append(number.description)
                self.secondNumber = Int(secondNumberString)
                self.prevNumber = Int(secondNumberString )
                
            } else {
                self.secondNumber = Int(number)
                self.prevNumber = Int(number)
            }

        }
    }
}
 
