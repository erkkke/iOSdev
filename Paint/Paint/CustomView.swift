//
//  CustomView.swift
//  Paint
//
//  Created by Erkebulan on 18.02.2021.
//

import UIKit

class CustomView: UIView {

    override func draw(_ rect: CGRect) {
        for i in Main.list {
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
        switch Main.figureType {
        case "rectangle":
            Main.list.append(Rectangle(Main.startPoint!, Main.endPoint, Main.color, Main.strokeWidth, Main.isFilled))
            break
        case "circle":
            Main.list.append(Circle(Main.startPoint!, Main.endPoint, Main.color, Main.strokeWidth, Main.isFilled))
            break
        case "line":
            Main.list.append(Line(Main.startPoint!, Main.endPoint, Main.color, Main.strokeWidth))
            break
        case "triangle":
            Main.list.append(Triangle(Main.startPoint!, Main.endPoint, Main.color, Main.strokeWidth, Main.isFilled))
            break
        case "pencil":
            Main.list.append(Line(Main.startPoint!, Main.endPoint, Main.color, Main.strokeWidth))
        default:
            break
        }
    }
    
    
    @IBAction func drawingMode(_ sender: UIButton) {
        Main.figureType = sender.restorationIdentifier
    }
    
    @IBAction func filling(_ sender: UISwitch) {
        Main.isFilled = sender.isOn
    }
    
    @IBAction func colorsType(_ sender: UIButton) {
        Main.color = Main.colors[sender.tag]
    }
    
    @IBAction func slider(_ sender: UISlider) {
        Main.strokeWidth = CGFloat(Int(sender.value))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            Main.startPoint = touch.location(in: self)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if Main.figureType == "pencil" {
                Main.endPoint = touch.location(in: self)
                addFigure()
                Main.startPoint = Main.endPoint
                setNeedsDisplay()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            Main.endPoint = touch.location(in: self)
        }
        addFigure()
        setNeedsDisplay()
    }

}


