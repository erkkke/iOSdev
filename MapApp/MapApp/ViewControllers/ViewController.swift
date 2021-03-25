//
//  ViewController.swift
//  MapApp
//
//  Created by Erkebulan on 21.03.2021.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController {

    var mapType: [Int: MKMapType] = [0: .standard, 1: .satellite, 2: .hybrid]
    var pins: [Pin] = []
    var selectedPin: MKAnnotation?
    var count = 0
    var cnt: Int {
        get {
            return count
        }
        set {
            if (newValue >= pins.count) {
                count = 0
            }
            else if (newValue < 0) {
                count = pins.count - 1
            }
            else if newValue < pins.count  {
                count = newValue
            }
        }
    }

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.mapType = .standard
        myMap.delegate = self
        myTableView.isHidden = true
        loadPins()
        loadMap()
    }
    
    func loadMap() {
        for pin in pins {
            addPinToMap(pin: pin)
        }
    }

    @IBAction func longTap(_ sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: self.myMap)
        let coordinate = self.myMap.convert(touchPoint, toCoordinateFrom: self.myMap)
        
        let alertController = UIAlertController(title: "New location", message: "Fill the fields", preferredStyle: .alert)
        alertController.addTextField{(textField) in textField.placeholder = "Location"}
        alertController.addTextField{(textField) in textField.placeholder = "Description"}
        
        let save = UIAlertAction(title: "Ok", style: .default, handler: {[weak self](alert) in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            
            let annotation = MKPointAnnotation()
            annotation.title = firstTextField.text
            annotation.subtitle = secondTextField.text
            annotation.coordinate = coordinate
            
            self?.myMap.addAnnotation(annotation)
            self?.savePin(location: annotation.title!, description: annotation.subtitle!, latitude: coordinate.latitude, longitude: coordinate.longitude)
            self?.myTableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func mySegment(_ sender: UISegmentedControl) {
        myMap.mapType = mapType[sender.selectedSegmentIndex] ?? .standard
    }

    @IBAction func pinsList(_ sender: UIBarButtonItem) {
        myTableView.isHidden = !myTableView.isHidden
    }
    
    @IBAction func nextPin(_ sender: UIBarButtonItem) {
        if !pins.isEmpty {
            cnt += 1
            showAnnotation(index: cnt)
        }
    }
    
    @IBAction func previousPin(_ sender: UIBarButtonItem) {
        if !pins.isEmpty {
            cnt -= 1
            showAnnotation(index: cnt)
        }
    }
    
    
    
    func savePin(location: String, description: String, latitude: Double, longitude: Double) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            if let entity = NSEntityDescription.entity(forEntityName: "Pin", in: context) {
                let pin = NSManagedObject(entity: entity, insertInto: context)
                pin.setValue(location, forKey: "pinLocation")
                pin.setValue(description, forKey: "pinDescription")
                pin.setValue(latitude, forKey: "latitude")
                pin.setValue(longitude, forKey: "longtitude")
                do {
                    try context.save()
                    pins.append(pin as! Pin)
                }
                catch {}
            }
        }
    }
    
    
    func loadPins() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Pin>(entityName: "Pin")
            do {
                try pins = context.fetch(fetchRequest)
            }
            catch {}
        }
    }
    
    func deletePin(object: Pin) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            context.delete(object)
            do {
                try context.save()
            }
            catch {}
        }
    }
    
    func showAnnotation(index: Int) {
        let coordinate = getCoordinate(index: index)
        let annotation = getAnnotation(coordinate: coordinate)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        
        navItem.title = annotation.title!!
        myMap.selectAnnotation(annotation, animated: true)
        myMap.setRegion(MKCoordinateRegion(center: coordinate, span: span), animated: true)
    }
    
    func getAnnotation(coordinate: CLLocationCoordinate2D) -> MKAnnotation {
        let index = myMap.annotations.firstIndex { (i) -> Bool in
            return i.coordinate.latitude == coordinate.latitude && i.coordinate.longitude == coordinate.longitude
        }
        return myMap.annotations[index!]
    }
    
    func getCoordinate(index: Int) -> CLLocationCoordinate2D {
        let pin = pins[index]
        return CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longtitude)
    }
    
    func addPinToMap(pin: Pin) {
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longtitude)
        annotation.coordinate = coordinate
        annotation.title = pin.pinLocation
        annotation.subtitle = pin.pinDescription
        
        myMap.addAnnotation(annotation)
    }
}


extension ViewController: EditPinDelegate {
    func editPin(location: String, description: String, coordinate: CLLocationCoordinate2D) {
        let index = pins.firstIndex{ (i) -> Bool in
            return i.latitude == coordinate.latitude && i.longtitude == coordinate.longitude
        }
        deletePin(object: pins[index!])
        savePin(location: location, description: description, latitude: coordinate.latitude, longitude: coordinate.longitude)
        loadPins()
        myMap.removeAnnotation(selectedPin!)
        addPinToMap(pin: pins[pins.count - 1])
        print("delegated")
    }

}

