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
    var color: UIColor = .black
    var list: Array<Figures> = []
    var isFilled = true
    var strokeWidth: CGFloat = 5
    var colors: Array<UIColor> = [.green, .blue, .orange, .systemPink, .purple, .red, .systemTeal, .yellow]
    

    override func draw(_ rect: CGRect) {
            for i in list {
                if i is Rectangle {
                    let rect = i as! Rectangle
                    rect.drawPath()
                }
                else if i is Circle {
                    let circle = i as! Circle
                    circle.drawPath()
                }
                else if i is Line {
                    let line = i as! Line
                    line.drawPath()
                }
                else if i is Triangle {
                    let triangle = i as! Triangle
                    triangle.drawPath()
                }
            }
    }

    func addFigure() {
        switch figureType {
        case "rectangle":
            list.append(Rectangle(startPoint!, endPoint, color, strokeWidth, isFilled))
            break
        case "circle":
            list.append(Circle(startPoint!, endPoint, color, strokeWidth, isFilled))
            break
        case "line":
            list.append(Line(startPoint!, endPoint, color, strokeWidth))
            break
        case "triangle":
            list.append(Triangle(startPoint!, endPoint, color, strokeWidth, isFilled))
            break
        case "pencil":
            list.append(Line(startPoint!, endPoint, color, strokeWidth))
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startPoint = touch.location(in: self)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if figureType == "pencil" {
                endPoint = touch.location(in: self)
                addFigure()
                startPoint = endPoint
                setNeedsDisplay()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            endPoint = touch.location(in: self)
        }
        addFigure()
        setNeedsDisplay()
    }
    
    @IBAction func drawingMode(_ sender: UIButton) {
        figureType = sender.restorationIdentifier
    }
    
    @IBAction func undo(_ sender: UIButton) {
        if !list.isEmpty {
            list.removeLast()
        }
        setNeedsDisplay()
}

//    @IBOutlet weak var undoButton: UIButton!
//    @objc func tap() {
//        if !list.isEmpty {
//            list.removeLast()
//            setNeedsDisplay()
//        }
//    }
//
//    @objc func longPress() {
//        if !list.isEmpty {
//            list.removeAll()
//            setNeedsDisplay()
//        }
//    }
    
    @IBAction func filling(_ sender: UISwitch) {
        isFilled = sender.isOn
    }
    
    @IBAction func colorsType(_ sender: UIButton) {
        color = colors[sender.tag]
    }
    
    
}


