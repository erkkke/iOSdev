//
//  TableViewController.swift
//  AnimationExample
//
//  Created by Erkebulan on 01.04.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var phones: [Phone] = [Phone(name: "iPhone 7 Plus", price: "350$", cpu: "A10 Fusion", detail: "12MPX"),
                           Phone(name: "Samsung Galaxy S8", price: "500$", cpu: "Snapdragon 835", detail: "12MPX"),
                           Phone(name: "LG G4", price: "400$", cpu: "Snapdragon 808", detail: "16MPX"),
                           Phone(name: "Nexus 6P", price: "700$", cpu: "Snapdragon 810", detail: "12.3MPX"),
                           Phone(name: "HTC One M9", price: "350$", cpu: "Snapdragon 810", detail: "20MPX"),
                           Phone(name: "Google Pixel", price: "350$", cpu: "Snapdragon 821", detail: "12MPX"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomCell
        let selectedPhone = phones[indexPath.row]
        cell.nameLabel.text = selectedPhone.name
        cell.priceLabel.text = selectedPhone.price
        cell.infoButton.tag = indexPath.row
        
        cell.detailInfoView = createDetailView(index: indexPath.row, cell: cell, phone: selectedPhone)
        cell.addSubview(cell.detailInfoView!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: -tableView.bounds.width, y: 0)
        cell.alpha = 0.2
        
        UIView.animate(withDuration: 0.5, delay: 0.25 * Double(indexPath.row)) {
            cell.transform = CGAffineTransform.identity
            cell.alpha = 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    @IBAction func cellButton(_ sender: UIButton) {
        let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! CustomCell

        if cell.detailInfoView!.isHidden {
            UIView.transition(with: cell.detailInfoView!, duration: 0.75, options: .transitionFlipFromLeft) {
                cell.detailInfoView!.alpha = 1
                cell.detailInfoView!.isHidden = false
            }
        }
        else {
            UIView.animate(withDuration: 0.4) {
                cell.detailInfoView!.frame.origin.x = cell.detailInfoView!.frame.width
                cell.detailInfoView!.alpha = 0
            } completion: { (Bool) in
                cell.detailInfoView!.frame.origin.x = 0
                cell.detailInfoView!.isHidden = true
            }
        }
    }
    
    func createDetailView(index: Int, cell: UITableViewCell, phone: Phone) -> UIView {
        let detailView = UIView()

        detailView.backgroundColor = UIColor.systemIndigo
        detailView.bounds.size.width = cell.bounds.width
        detailView.bounds.size.height = cell.bounds.height
        detailView.frame.origin.x = 0
        detailView.frame.origin.y = 0
        detailView.isHidden = true
        

        let cpuLabel = UILabel()
        let detailLabel = UILabel()
        let hideButton = UIButton()


        cpuLabel.text = phone.cpu
        cpuLabel.textColor = .white
        cpuLabel.font = UIFont.boldSystemFont(ofSize: 19)
        cpuLabel.bounds.size.height = CGFloat(24)

        detailLabel.text = phone.detail
        detailLabel.textColor = .white
        detailLabel.font = UIFont.boldSystemFont(ofSize: 17)
        detailLabel.bounds.size.height = CGFloat(21)

        hideButton.tag = index
        hideButton.setTitle("Hide", for: UIControl.State.normal)
        hideButton.setTitleColor(.white, for: UIControl.State.normal)
        hideButton.layer.borderWidth = 1
        hideButton.layer.cornerRadius = 6
        hideButton.layer.borderColor = UIColor.white.cgColor
        hideButton.bounds.size.width = CGFloat(30)
        hideButton.addTarget(self, action: #selector(cellButton), for: .touchUpInside)
        
        detailView.addSubview(cpuLabel)
        
        cpuLabel.translatesAutoresizingMaskIntoConstraints = false
        cpuLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: CGFloat(10)).isActive = true
        cpuLabel.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: CGFloat(50)).isActive = true
        cpuLabel.rightAnchor.constraint(equalTo: detailView.rightAnchor, constant: CGFloat(-90)).isActive = true

        detailView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.topAnchor.constraint(equalTo: cpuLabel.bottomAnchor, constant: CGFloat(5)).isActive = true
        detailLabel.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: CGFloat(50)).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: detailView.rightAnchor, constant: CGFloat(-90)).isActive = true
        
        detailView.addSubview(hideButton)
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.rightAnchor.constraint(equalTo: detailView.rightAnchor, constant: CGFloat(-20)).isActive = true
        hideButton.centerYAnchor.constraint(equalTo: detailView.centerYAnchor).isActive = true
        hideButton.leftAnchor.constraint(equalTo: cpuLabel.rightAnchor, constant: CGFloat(10)).isActive = true
        
        return detailView
    }
    
}
