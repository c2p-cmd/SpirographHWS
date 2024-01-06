//
//  Extensions.swift
//  SpirographHWS
//
//  Created by Sharan Thakur on 06/01/24.
//

import Foundation

extension Int {
    func toDouble() -> Double {
        Double(self)
    }
    
    func gcd(other b: Int) -> Int {
        var a = self
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
}

extension Double {
    func toInt() -> Int {
        Int(self)
    }
    
    func toString(till limits: Int = 2) -> String {
        formatted(.number.precision(.fractionLength(limits)))
    }
 }
