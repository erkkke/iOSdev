//
//  CustomView.swift
//  Paint
//
//  Created by Erkebulan on 18.02.2021.
//

import UIKit

class CustomView: UIView {
    
    var startPoint: CGPoint?, endPoint: CGPoint!
    
    var figureType: String? = "rectangle"
    var figure: Figures?
    var list = [Figures]()
    
    override func draw(_ rect: CGRect) {

        if let startPosition = startPoint{
            
            switch figureType {
            case "rectangle":
                figure = Rectangle(startPosition, endPoint, .green, 4, false)
                break
            case "circle":
                let radius = max(abs(startPosition.x - endPoint.x)/2, abs(startPosition.y - endPoint.y) / 2)
                let center = CGPoint(x: startPosition.x + abs(startPosition.x - endPoint.x)/2, y: startPosition.y + abs(startPosition.y - endPoint.y)/2)
                figure = Circle(radius, center, .blue, 4, false)
                break
            case "line":
                break
            default:
                break
            }
            
            list.append(figure!)

            for i in list {
                if i is Rectangle {
                    let rect = i as! Rectangle
                    rect.drawPath()
                }
                else if i is Circle {
                    let circle = i as! Circle
                    circle.drawPath()
                }
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startPoint = touch.location(in: self)
        }
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            endPoint = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    @IBAction func drawingMode(_ sender: UIButton) {
        switch sender.currentTitle {
        case "●":
            figureType = "circle"
            break
        case "◼︎":
            figureType = "rectangle"
            break
        case "╱":
            figureType = "line"
            break
        case "◣":
            figureType = "triangle"
            break
        case "✏️":
            figureType = "pencil"
            break
        default:
            break
        }
    }
    
    
    
}


