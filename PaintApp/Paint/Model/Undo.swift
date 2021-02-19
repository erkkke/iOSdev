//
//  Undo.swift
//  Paint
//
//  Created by Erkebulan on 19.02.2021.
//
//
//import Foundation
//import UIKit
//
//class Undo {
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
//    let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
//    
//    @objc func tap() {
//        if !list.isEmpty {
//            CustomView.list.removeLast()
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
//}
