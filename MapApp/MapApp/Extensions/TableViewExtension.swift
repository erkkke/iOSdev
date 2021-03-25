//
//  TableViewExtension.swift
//  MapApp
//
//  Created by Erkebulan on 24.03.2021.
//

import Foundation
import MapKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Location", for: indexPath)
        cell.textLabel?.text = pins[indexPath.row].pinLocation
        cell.detailTextLabel?.text = pins[indexPath.row].pinDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
        myTableView.isHidden = true
        showAnnotation(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let coordinate = getCoordinate(index: indexPath.row)
            deletePin(object: pins[indexPath.row])
            loadPins()
            myMap.removeAnnotation(getAnnotation(coordinate: coordinate))
            myTableView.reloadData()
        }
    }
}
