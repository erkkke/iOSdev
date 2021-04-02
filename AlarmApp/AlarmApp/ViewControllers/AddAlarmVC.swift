//
//  AddVC.swift
//  AlarmApp
//
//  Created by Erkebulan on 12.03.2021.
//

import UIKit

class AddAlarmVC: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    
    var addDelegate: AddAlarmDelegate?
    var alarm: Alarm?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.datePickerMode = UIDatePicker.Mode.time
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let date = getDate()
        alarm = Alarm(time: date, description: textField.text)
        addDelegate?.addAlarm(alarm!)
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDate() -> String {
        let date = DateFormatter()
        date.dateFormat = "HH:mm"

        return date.string(from: timePicker.date)
    }
}
