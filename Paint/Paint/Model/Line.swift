//
//  Line.swift
//  Paint
//
//  Created by Erkebulan on 19.02.2021.
//

import Foundation
import UIKit

class Line: Figure {
    private var p1: CGPoint
    private var p2: CGPoint
    
    init(_ startPoint: CGPoint, _ endPoint: CGPoint, _ color: UIColor, _ strokeWidth: CGFloat) {
        p1 = startPoint
        p2 = endPoint
        super.init(color, strokeWidth)
    }
    
    func drawPath() {
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.lineWidth = strokeWidth
        color.set()
        path.stroke()
    }
}
