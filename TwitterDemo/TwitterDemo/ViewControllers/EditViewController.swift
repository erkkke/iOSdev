//
//  EditViewController.swift
//  TwitterDemo
//
//  Created by Erkebulan on 15.04.2021.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

protocol UpadateProfileInfoDelegate {
    func updateInfo(name: String, surname: String, date: String)
}

class EditViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    

    @IBOutlet weak var changeAvatarButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var userName: String?
    var userSurname: String?
    var date: String?
    var updateDelegate: UpadateProfileInfoDelegate?
    
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius = avatar.frame.height/2
        saveButton.layer.cornerRadius = 2
        
        name.text = userName
        surname.text = userSurname
        dateFormat()
        updateAvatar()

    }
    
    @IBAction func updateImageButtonClicked(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let imageData = image.pngData() else {return}
        indicator.startAnimating()
        storage.child("avatars/\(Auth.auth().currentUser!.uid)/avatar.png").putData(imageData, metadata: nil) { [weak self] (_, error) in
            guard error == nil else {
                self?.showMessage(title: "Warning", message: "Some error were occured while uploading image")
                return
            }
            self?.indicator.stopAnimating()
        }
        updateAvatar()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let df = DateFormatter()
        df.dateFormat = "MMM d, yyyy"
        let birthdayDate = df.string(from: birthday.date)
        updateDelegate?.updateInfo(name: name.text!, surname: surname.text!, date: birthdayDate)
        dismiss(animated: true, completion: nil)
    }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func dateFormat() {
        let df = DateFormatter()
        df.dateFormat = "MMM d, yyyy"
        let mydate = df.date(from: date!)
        birthday.date = mydate!
    }
    
    
    func updateAvatar() {
        let islandRef = Storage.storage().reference().child("avatars/\(Auth.auth().currentUser!.uid)/avatar.png")
        islandRef.getData(maxSize: 5 * 1024 * 1024) { [weak self] data, error in
            if error == nil {
                let image = UIImage(data: data!)
                self?.avatar.image = image
                self?.avatar.layer.cornerRadius = (self?.avatar.frame.height)!/2
            } else {
                print(error!)
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

}
