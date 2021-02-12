//
//  ViewController.swift
//  Contacts
//
//  Created by Erkebulan on 11.02.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var isNoContact: UILabel!
    
//    var contacts: [myContacts] = []
    var contacts: [myContacts] = [myContacts.init("Sosiska", "87076919175", UIImage.init(imageLiteralResourceName: "male"))]
    var isDeleted = false;
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomCell
        
        if !contacts.isEmpty {
            cell?.contactName.text = contacts[indexPath.row].name
            cell?.contactNumber.text = contacts[indexPath.row].number
            cell?.contactImage.image = contacts[indexPath.row].image
        }
        

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }


    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let index = myTableView.indexPathForSelectedRow?.row {
            let destination = segue.destination as! DetailViewController
            destination.name = contacts[index].name
            destination.number = contacts[index].number
            destination.image = contacts[index].image
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

