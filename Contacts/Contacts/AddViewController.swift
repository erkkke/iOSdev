//
//  AddViewController.swift
//  Contacts
//
//  Created by Erkebulan on 12.02.2021.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var name: String?
    var number: String?
    var male: String?
    
    @IBAction func saveButton(_ sender: UIButton) {
        
    }
    @IBOutlet weak var textNumber: UITextField!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var pickGender: UIPickerView!
    
    
    
    var pickerData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickGender.delegate = self
        self.pickGender.dataSource = self

        pickerData = ["male", "female"]
        
        name = textName.text
        number = textNumber.text
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }

}
