//
//  AlarmsVC.swift
//  AlarmApp
//
//  Created by Erkebulan on 12.03.2021.
//

import UIKit

class AlarmsVC: UITableViewController, EditAlarmDelegate, DeleteAlarmDelegate, AddAlarmDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Main.alarms.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? CustomCell
        cell?.timeLabel.text = Main.alarms[indexPath.row].time
        cell?.descriptionLabel.text = Main.alarms[indexPath.row].description

        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableView.indexPathForSelectedRow?.row
        if segue.identifier == "edit" {
            let destination = segue.destination as! EditAlarmVC
            destination.alarm = Main.alarms[index!]
            destination.ind = index
            destination.deleteDelegate = self
            destination.editDelegate = self
        }
        else if segue.identifier == "add" {
            let destination = segue.destination as! AddAlarmVC
            destination.addDelegate = self
        }
    }
    
    
    func editAlarm(_ index: Int, _ alarm: Alarm) {
        Main.alarms[index] = alarm
        tableView.reloadData()
    }
    
    func deleteAlarm(_ index: Int) {
        Main.alarms.remove(at: index)
        tableView.reloadData()
    }

    func addAlarm(_ alarm: Alarm) {
        Main.alarms.append(alarm)
        print(Main.alarms)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Main.alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
