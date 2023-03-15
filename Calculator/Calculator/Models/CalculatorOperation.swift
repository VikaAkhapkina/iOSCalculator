//
//  CalculatorOperation.swift
//  Calculator
//
//  Created by Viktoriya on 15.03.23.
//

import Foundation

enum CalculatorOperation {
    case divite
    case multiply
    case subtract
    case add
    
    var title: String {
        switch self {
        case .divite:
            return "+"
        case .multiply:
            return "×"
        case .subtract:
            return "-"
        case .add:
            return "+"
        }
    }
}
