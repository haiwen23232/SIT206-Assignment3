//
//  TripsMapViewController.swift
//  Trip Gallery
//
//  Created by HANSON ZHOU on 1/5/18.
//  Copyright © 2018 HANSON ZHOU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TripsMapViewController: UIViewController, LocationObserver, MKMapViewDelegate{
    
    func locationDidChange(newLocations: [CLLocation]) {
        //
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tripsMap.delegate = self
        tripsMap.showsUserLocation = true
        if Trips.trips.count <= 0 {
            Trips.loadTrips(completion: {
                DispatchQueue.main.async {
                    for trip in Trips.trips{
                        self.tripsMap.addAnnotation(trip)
                }
                }
            })
        }
        
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tripsMap: MKMapView!
    let locationManager = CLLocationManager()
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationId = "viewForAnnoation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId)
        if((annotation as? Trip) != nil){
            if annotationView == nil{
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
                annotationView?.image = UIImage(data:(annotation as! Trip).img!)
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView?.canShowCallout = true
            }
            else { annotationView?.annotation = annotation}
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tripDetails")
        (vc as! TripsDetailsViewController).trip = view.annotation as? Trip
        self.present(vc!, animated: true, completion: nil)
    }
    
    func locationManger(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let region = MKCoordinateRegion(center: locations[0].coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        tripsMap.setRegion( region, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
