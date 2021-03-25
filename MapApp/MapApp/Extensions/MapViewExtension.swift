//
//  MapViewExtension.swift
//  MapApp
//
//  Created by Erkebulan on 24.03.2021.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Annotation")
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Annotation")
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            btn.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
            annotationView?.rightCalloutAccessoryView = btn
        }
        else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedPin = view.annotation
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        navItem.title = (selectedPin?.title)!
        myMap.setRegion(MKCoordinateRegion(center: selectedPin!.coordinate, span: span), animated: true)
    }
    
    @objc func infoAction(sender: UIButton) {
        let editVC = (storyboard?.instantiateViewController(identifier: "EditViewController")) as! EditViewController
        
        editVC.locationText = (selectedPin?.title)!
        editVC.descriptionText = (selectedPin?.subtitle)!
        editVC.coordinate = selectedPin?.coordinate
        editVC.myDelegate = self
        show(editVC, sender: self)
    }
}
