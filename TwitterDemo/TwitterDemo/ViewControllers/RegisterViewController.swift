//
//  RegisterViewController.swift
//  TwitterDemo
//
//  Created by Erkebulan on 04.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth

protocol SegueToLoginPageDelegate {
    func segueToLoginPage()
}

class RegisterViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var myDelegate: SegueToLoginPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        let df = DateFormatter()
        df.dateFormat = "MMM d, yyyy"
        let name = nameTextField.text
        let surname = surnameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let birthday = df.string(from: datePicker.date)
        
        if email != "" && password != "" && name != "" {
            indicator.startAnimating()
            Auth.auth().createUser(withEmail: email!, password: password!) { [weak self] (result, error) in
                self?.indicator.stopAnimating()
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                if error == nil {
                    self?.showMessage(title: "Success", message: "Please, verify your email.")
                    let userInfo = ["name": name, "surname": surname, "birthday": birthday]
                    Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).setValue(userInfo)
                }
                else {
                    self?.showMessage(title: "Error", message: "Some error were occured.")
                }
            }
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
        
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] (UIAlertAction) in
            if title != "Error" {
                self?.dismiss(animated: true, completion: {
                    self?.myDelegate?.segueToLoginPage()
                })
            }
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
