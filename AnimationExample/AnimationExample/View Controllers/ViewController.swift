//
//  ViewController.swift
//  AnimationExample
//
//  Created by Erkebulan on 29.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginAnimation(isClosing: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        loginAnimation(isClosing: true)
    }
    
    func loginAnimation(isClosing: Bool) {
        if !isClosing {
            emailTextField.center = CGPoint(x: 0, y: emailTextField.center.y)
            passwordTextField.center = CGPoint(x: view.bounds.width, y: passwordTextField.center.y)
            nextButton.alpha = 0
            UIView.animate(withDuration: 1.25) { [weak self] in
                self?.emailTextField.center = CGPoint(x: self!.view.bounds.width / 2, y: self!.emailTextField.center.y)
                self?.passwordTextField.center = CGPoint(x: self!.view.bounds.width / 2, y: self!.passwordTextField.center.y)
            }
            
            UIView.animate(withDuration: 1, delay: 1.25) { [weak self] in
                self?.nextButton.alpha = 1
            }
        }
        
        else {
            UIView.animate(withDuration: 1.25) { [weak self] in
                self?.emailTextField.center = CGPoint(x: 0, y: self!.emailTextField.center.y)
                self?.passwordTextField.center = CGPoint(x: self!.view.bounds.width, y: self!.passwordTextField.center.y)
            }
            
            UIView.animate(withDuration: 2) { [weak self] in
                self?.nextButton.alpha = 0
            }
        }
    }
    
    func loginView() {
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        nextButton.layer.cornerRadius = 6
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor
    }
}

