//
//  Circle.swift
//  Paint
//
//  Created by Erkebulan on 18.02.2021.
//

import Foundation
import UIKit

class Circle: Figures {
    
    private var radius: CGFloat
    private var circleCenter: CGPoint
    
    init(_ radius: CGFloat, _ circleCenter: CGPoint, _ color: UIColor, _ strokeWidth: CGFloat, _ isFilled: Bool) {
        self.radius = radius
        self.circleCenter = circleCenter
        super.init(color, strokeWidth, isFilled)
    }
    
    
    func drawPath() {
        let path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: 0, endAngle: 2 * Double.pi.cg, clockwise: true)
        path.lineWidth = strokeWidth
        color.set()
        isFilled ? path.fill() : path.stroke()
    }
}


