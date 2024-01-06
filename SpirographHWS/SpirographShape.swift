//
//  SpirographShape.swift
//  SpirographHWS
//
//  Created by Sharan Thakur on 06/01/24.
//

import SwiftUI

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Double
    let amount: Double
    
    func path(in rect: CGRect) -> Path {
        let divisor = innerRadius.gcd(other: outerRadius)
        
        let outerRadius = self.outerRadius.toDouble()
        let innerRadius = self.innerRadius.toDouble()
        
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / divisor.toDouble()) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, to: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            let movePoint = CGPoint(x: x, y: y)
            if theta == 0 {
                path.move(to: movePoint)
            } else {
                path.addLine(to: movePoint)
            }
        }
        
        return path
    }
}
