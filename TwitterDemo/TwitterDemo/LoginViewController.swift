//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Erkebulan on 04.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = Auth.auth().currentUser
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentUser = Auth.auth().currentUser
        if (currentUser != nil && currentUser!.isEmailVerified) {
            goToMainPage()
        }
    }
    
    

    @IBAction func loginButtonClicked(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        indicator.startAnimating()
        
        if email != "" && password != "" {
            Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] (result, error) in
                self?.indicator.stopAnimating()
                if error == nil {
                    if Auth.auth().currentUser!.isEmailVerified {
                        self?.goToMainPage()
                    }
                    else {
                        self?.showMessage(title: "Warning", message: "Your email is not verified")
                    }
                }
                else {
                    self?.showMessage(title: "Warning", message: "Incorrect email or password")
                }
            }
        }
        else {
            indicator.stopAnimating()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToMainPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let mainPage = storyboard.instantiateViewController(identifier: "MainPageViewController") as? MainPageViewController {
                mainPage.modalPresentationStyle = .fullScreen
                present(mainPage, animated: true, completion: nil)
            }
        }
}
