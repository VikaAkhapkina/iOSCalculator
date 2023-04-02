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
    
    private(set) var firstNumber: Int? = nil { didSet { self.calcHeaderLabel = self.firstNumber?.description ?? "0" }}
    private(set) var secondNumber: Int? = nil { didSet { self.calcHeaderLabel = self.secondNumber?.description ?? "0" }}
    
    private(set) var operation: CalculatorOperation? = nil
    
    //MARK: - Memory Variables
    private(set) var prevNumber: Int? = nil
    private(set) var prevOperation: CalculatorOperation? = nil
}

// MARK: - Selection Numbers
extension CalcControllerViewModel {
    
    public func didSelectButton(with calcButton: CalculatorButton){
        
        switch calcButton {
        case .allClear: self.didSelectAllClear()
        case .plusMines: fatalError()
        case .percentage: fatalError()
        case .divide: self.didSelectionOperation(with: .divite)
        case .multiply: self.didSelectionOperation(with: .multiply)
        case .subtract: self.didSelectionOperation(with: .subtract)
        case .add: self.didSelectionOperation(with: .add)
        case .equals: fatalError()
        case .number(let number): self.didSelectNumber(with: number)
        case .decimal: fatalError()
        }
        
        self.updateView?()
    }
    
    private func didSelectAllClear() {
        self.currentNumber = .firstNumber
        self.firstNumber = nil
        self.secondNumber = nil
        self.operation = nil
        self.prevNumber = nil
        self.prevOperation = nil
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

// MARK: - Equals & Arithmetic Operation
extension CalcControllerViewModel {
    
    private func didSelectionOperation(with operation: CalculatorOperation) {
        
        if currentNumber == .firstNumber {
            self.operation = operation
            currentNumber = .secondNumber
        } else if currentNumber == .secondNumber {
            
            if let prevOperation = self.operation, let firstNumber = self.firstNumber, let secondNumber = self.secondNumber {
                let resalt = getOperationResult(operation, firstNumber, secondNumber)
                self.secondNumber = nil
                self.firstNumber = resalt
                self.currentNumber = .secondNumber
                self.operation = operation
            } else {
                self.operation = operation
        }
    }
    }
       
    // MARK: - Helper
    private func getOperationResult(_ operation: CalculatorOperation, _ firstNumber: Int, _ secondNumber: Int) -> Int {

        switch operation {
        case .divite:
            return (firstNumber / secondNumber)
        case .multiply:
            return (firstNumber * secondNumber)
        case .subtract:
            return (firstNumber - secondNumber)
        case .add:
            return (firstNumber + secondNumber)

        }
    }
}
