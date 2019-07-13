//
//  Map.swift
//  Incident Map
//
//  Created by diondre lewis on 7/12/19.
//  Copyright © 2019 Diondre Lewis. All rights reserved.
//

import Cocoa
import MapKit

class MapViewController: NSViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override var representedObject: Any? {
        didSet {
            if let (cad, _) = representedObject as? (Cad, DSTimeMachineResult) {
                let coordinate = CLLocationCoordinate2D(latitude: cad.address.latitude, longitude: cad.address.longitude)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                
                mapView.addAnnotation(annotation)
                mapView.setCamera(MKMapCamera(lookingAtCenter: coordinate, fromEyeCoordinate: coordinate, eyeAltitude: 2000), animated: false)
            }
        }
    }
}
