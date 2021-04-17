//
//  FirstPageViewController.swift
//  TwitterDemo
//
//  Created by Erkebulan on 14.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class FirstPageViewController: UIViewController, SegueToLoginPageDelegate {
    
    var currentUser: User?
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountButton.layer.cornerRadius = 22
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentUser = Auth.auth().currentUser
        if (currentUser != nil && currentUser!.isEmailVerified) {
            goToMainPage()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "register" {
            let destination = segue.destination as! RegisterViewController
            destination.myDelegate = self
        }
    }
    
    func segueToLoginPage() {
        goToLoginPage()
    }
    
    func goToMainPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let mainPage = storyboard.instantiateViewController(identifier: "MainPageViewController") as? MainPageViewController {
                mainPage.modalPresentationStyle = .fullScreen
                present(mainPage, animated: true, completion: nil)
            }
        }
    
    func goToLoginPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let page = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
                page.modalPresentationStyle = .fullScreen
                present(page, animated: true, completion: nil)
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
    

}
