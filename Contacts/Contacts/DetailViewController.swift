//
//  DetailViewController.swift
//  Contacts
//
//  Created by Erkebulan on 12.02.2021.
//

import UIKit

class DetailViewController: UIViewController {
    var name: String?
    var number: String?
    var image: UIImage?
    
    
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var imageSegue: UIImageView!
    
    @IBAction func deleteContact(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameSurnameLabel.text = name
        numberLabel.text = number
        imageSegue.image = image
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
