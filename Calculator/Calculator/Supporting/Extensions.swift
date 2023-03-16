//
//  Extensions.swift
//  Calculator
//
//  Created by Viktoriya on 15.03.23.
//

import Foundation


extension Double {
    var toInt: Int? {
        return Int(self)
    }
}

extension String {
    var toDouble: Double? {
        return Double(self)
    }
}

extension FloatingPoint {
    var isInteger: Bool { return rounded() == self }
}
