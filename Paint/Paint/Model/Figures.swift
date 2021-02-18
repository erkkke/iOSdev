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
    var isFilled: Bool
    
    init(_ color: UIColor, _ strokeWidth: CGFloat, _ isFilled: Bool) {
        self.color = color
        self.strokeWidth = strokeWidth
        self.isFilled = isFilled
    }
}

extension Double {
    var cg: CGFloat {
        return CGFloat(self)
    }
}
