//
//  EditAlarmVC.swift
//  AlarmApp
//
//  Created by Erkebulan on 12.03.2021.
//

import UIKit



class EditAlarmVC: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    
    var deleteDelegate: DeleteAlarmDelegate?
    var editDelegate: EditAlarmDelegate?
    var alarm: Alarm?
    var ind: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatDate()
        textField.text = alarm?.description
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeButton(_ sender: UIButton) {
        alarm?.description = textField.text
        alarm?.time = getStringDate()
        
        editDelegate?.editAlarm(ind!, alarm!)
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func deleteButton(_ sender: UIButton) {
        deleteDelegate?.deleteAlarm(ind!)
        navigationController?.popViewController(animated: true)
    }
    
    
    func getStringDate() -> String {
        let date = DateFormatter()
        date.dateFormat = "HH:mm"
        
        return date.string(from: timePicker.date)
    }
    
    
    func formatDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let date = dateFormatter.date(from: (alarm?.time)!)
        timePicker.datePickerMode = UIDatePicker.Mode.time
        timePicker.date = date!
    }

}

