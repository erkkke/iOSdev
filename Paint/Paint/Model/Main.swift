//
//  Main.swift
//  Paint
//
//  Created by Erkebulan on 19.02.2021.
//

import Foundation
import UIKit

struct Main {
    static var startPoint: CGPoint?, endPoint: CGPoint!
    static var figureType: String? = "pencil"
    static var color: UIColor = .blue
    static var list: Array<Figure> = []
    static var isFilled = false
    static var strokeWidth: CGFloat = 2
    static var colors: Array<UIColor> = [.green, .blue, .orange, .systemPink, .purple, .red, .systemTeal, .yellow]
}
