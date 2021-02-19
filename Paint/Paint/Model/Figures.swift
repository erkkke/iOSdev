//
//  Figures.swift
//  Paint
//
//  Created by Erkebulan on 18.02.2021.
//

import Foundation
import UIKit

class Figures {
    var color: UIColor
    var strokeWidth: CGFloat
    var isFilled: Bool = false
    
    init(_ color: UIColor, _ strokeWidth: CGFloat, _ isFilled: Bool) {
        self.color = color
        self.strokeWidth = strokeWidth
        self.isFilled = isFilled
    }
    
    init(_ color: UIColor, _ strokeWidth: CGFloat) {
        self.color = color
        self.strokeWidth = strokeWidth
    }
}

extension Double {
    var cg: CGFloat {
        return CGFloat(self)
    }
}
