//
//  ViewController.swift
//  Paint
//
//  Created by Erkebulan on 18.02.2021.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var customView: CustomView!
    
    @IBOutlet weak var undoButton: UIButton!
    
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(long))
        tapGesture.numberOfTapsRequired = 1
        undoButton.addGestureRecognizer(tapGesture)
        undoButton.addGestureRecognizer(longGesture)
    }

    @objc func tap() {
        if !customView.list.isEmpty {
            customView.list.removeLast()
            customView.setNeedsDisplay()
        }
        }

    @objc func long() {
        if !customView.list.isEmpty {
            customView.list.removeAll()
            customView.setNeedsDisplay()
        }
    }

}

