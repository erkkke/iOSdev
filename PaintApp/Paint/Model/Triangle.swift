//
//  Triangle.swift
//  Paint
//
//  Created by Erkebulan on 19.02.2021.
//

import Foundation
import UIKit

class Triangle: Figures {
    private var p1: CGPoint
    private var p2: CGPoint
    private var p3: CGPoint
    
    init(_ startPoint: CGPoint, _ endPoint: CGPoint, _ color: UIColor,_ strokeWidth: CGFloat,_ isFilled: Bool) {
        p1 = startPoint
        p2 = endPoint
        p3 = CGPoint(x: min(p1.x, p2.x), y: max(p1.y, p2.y))
        super.init(color, strokeWidth, isFilled)
    }
    
    func drawPath() {
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p1)
        
        path.lineWidth = strokeWidth
        color.set()
        isFilled ? path.fill() : path.stroke()
    }
}
