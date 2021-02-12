//
//  ViewController.swift
//  Contacts
//
//  Created by Erkebulan on 11.02.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var contacts: [myContacts] = []
    
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
        
        else {
            cell?.contactName.text = "No contacts"
            cell?.contactNumber.text = "No contacts"
            cell?.contactImage.image = UIImage.init(named: "male")!
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
//        navigationController?.pushViewController(detailVC, animated: true)
        
        myTableView.deselectRow(at: indexPath, animated: true)
    }

    @IBOutlet weak var myTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = myTableView.indexPathForSelectedRow!.row
        let destination = segue.destination as! DetailViewController
        destination.name = contacts[index].name
        destination.number = contacts[index].number
        destination.image = contacts[index].image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

