//
//  SitesVC.swift
//  WebApp
//
//  Created by Erkebulan on 25.02.2021.
//

import UIKit

class SitesVC: UITableViewController, DetailViewDelegate {
    
    var newName: UITextField?, newURL: UITextField?
    
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    
    private var array: [Site] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Websites"
        array = Main.list
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].name

        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Main.list.remove(at: indexPath.row)
            array = segmentNumber()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let navcon = segue.destination as? UINavigationController,
               let destination = navcon.visibleViewController as? InfoVC,
               let row = tableView.indexPathForSelectedRow?.row {
                destination.webPage = array[row]
                destination.navigationItem.title = array[row].name
                destination.delegate = self
            }
        }
    }
    
    
    @IBAction func SegmentedControllAction(_ sender: UISegmentedControl) {
        array = segmentNumber()
        tableView.reloadData()
    }
    
    func segmentNumber()->[Site] {
        if mySegmentControl.selectedSegmentIndex == 0 {
            return Main.list
        }
        return Main.list.filter { $0.isFavorite }
    }

    func updateTableViewController() {
        array = segmentNumber()
        tableView.reloadData()
    }
    
    
    
    
    @IBAction func addNewWebSite(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Web Page", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: setNewSiteName)
        alert.addTextField(configurationHandler: setNewSiteUrl)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in print("cancelled")}))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: okButton))
        self.present(alert, animated: true)
    }
    
    func setNewSiteName(textField: UITextField) {
        newName = textField
        textField.placeholder = "Enter WebSite name"
    }
    
    func setNewSiteUrl (textField: UITextField) {
        newURL = textField
        textField.placeholder = "Enter URL"
        textField.keyboardType = UIKeyboardType.URL
    }
    
    func okButton(alert: UIAlertAction) {
        if (((newName?.text) != "" && (newURL?.text) != "")) {
            Main.list.append(Site(name: newName?.text, url: "https://www." + (newURL?.text)!))
            array = segmentNumber()
            tableView.reloadData()
        }
    }
    
    
}
