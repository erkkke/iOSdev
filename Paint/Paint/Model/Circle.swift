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
    
    init(_ startPoint: CGPoint, _ endPoint: CGPoint, _ color: UIColor, _ strokeWidth: CGFloat, _ isFilled: Bool) {
        radius = max(abs(startPoint.x - endPoint.x)/2, abs(startPoint.y - endPoint.y) / 2)
        circleCenter = CGPoint(x: startPoint.x + abs(startPoint.x - endPoint.x)/2, y: startPoint.y + abs(startPoint.y - endPoint.y)/2)
        super.init(color, strokeWidth, isFilled)
    }
    
    
    func drawPath() {
        let path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: 0, endAngle: 2 * Double.pi.cg, clockwise: true)
        path.lineWidth = strokeWidth
        color.set()
        isFilled ? path.fill() : path.stroke()
    }
}


