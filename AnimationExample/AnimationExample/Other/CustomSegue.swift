//
//  customSegue.swift
//  AnimationExample
//
//  Created by Erkebulan on 29.03.2021.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        segueAnimation()
    }
    
    func segueAnimation() {
        let destinationVC = self.destination
        let sourceVC = self.source
        
        destinationVC.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        sourceVC.view.superview?.addSubview(destinationVC.view)
        
        UIView.animate(withDuration: 1.5) {
            sourceVC.view.alpha = 0
            destinationVC.view?.transform = CGAffineTransform.identity
        } completion: { (Bool) in
            destinationVC.modalPresentationStyle = .fullScreen
            sourceVC.present(destinationVC, animated: false, completion: nil)
        }
    }
}
