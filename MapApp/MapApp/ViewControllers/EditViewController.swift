//
//  EditViewController.swift
//  MapApp
//
//  Created by Erkebulan on 23.03.2021.
//

import UIKit
import MapKit

protocol EditPinDelegate {
    func editPin(location: String, description: String, coordinate: CLLocationCoordinate2D)
}

class EditViewController: UIViewController {
    var myDelegate: EditPinDelegate?
    var locationText: String?
    var descriptionText: String?
    var coordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.text = locationText!
        descriptionTextField.text = descriptionText!
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        myDelegate?.editPin(location: locationTextField.text!, description: descriptionTextField.text!, coordinate: coordinate!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
