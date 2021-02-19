//
//  Rectangle.swift
//  Paint
//
//  Created by Erkebulan on 18.02.2021.
//

import Foundation
import UIKit

class Rectangle: Figure {
    private var p1: CGPoint
    private var p2: CGPoint
    
    init(_ p1: CGPoint, _ p2: CGPoint, _ color: UIColor, _ strokeWidth: CGFloat, _ isFilled: Bool) {
        self.p1 = p1
        self.p2 = p2
        super.init(color, strokeWidth, isFilled)
    }
    
    func drawPath() {
        let rect = CGRect(origin: p1, size: CGSize(width: abs(p2.x - p1.x), height: abs(p2.y - p1.y)))
        let path = UIBezierPath(rect: rect)
        color.set()
        isFilled ? path.fill() : path.stroke()
    }
}
