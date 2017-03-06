//
//  MainPageVC.swift
//  ibdaa-app
//
//  Created by Killvak on 21/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MainPageVC: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate , RidesController{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinImageView: UIImageView!
    
    
    
    let locationManager = CLLocationManager()
    private var userLocation : CLLocationCoordinate2D?
   var mapViewIsZoomedIN = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        RideHandler.Instance.delegate = self
        RideHandler.Instance.observeMessagesForDriver()
        // Do any additional setup after loading the view.
    }
    /**
 before u add annoations u have to remove them 
     
     mapView.removeAnnotatio s(mapVieew,annotations)
 */
    
    //RideControlelr Protocol
    func acceptRide(lat: Double, long: Double) {
         print("YO YO YO DELEgate is ONNNNN , \(lat) , long : \(long)")
        riderRequest(title: "Ride Requst", sms: "you have a request ", requestAlive: true)
    }
    
    
    private func riderRequest(title : String , sms : String , requestAlive: Bool) {
        
        let alert = UIAlertController(title: title, message: sms, preferredStyle: .alert)
        
        if requestAlive {
            let accept = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil   )
            
            alert.addAction(accept)
            alert.addAction(cancel)
        }else {
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil   )
        alert.addAction(ok)
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    //@end Protocol
    @IBAction func requestARide(_ sender: Any) {
        RideHandler.Instance.requestRide(lat: self.mapView.centerCoordinate.latitude, lang: mapView.centerCoordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location?.coordinate {
            userLocation = CLLocationCoordinate2DMake(location.latitude, location.longitude)
//            let region = MKCoordinateRegionMake(userLocation!, MKCoordinateSpanMake(0.01, 0.01))
//            
//            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if  mapViewIsZoomedIN {
        print("Zoomed in regionDidChangeAnimated \(self.mapView.centerCoordinate) ")
        self.mapViewIsZoomedIN = false
        delay(delay: 2.0){
            self.mapViewIsZoomedIN = true
            self.animateImage()
            return
            }
        }
    }
    
    func animateImage() {
        self.pinImageView.animationImages = [ #imageLiteral(resourceName: "pin-1"),#imageLiteral(resourceName: "pin-2"),#imageLiteral(resourceName: "pin-3"),#imageLiteral(resourceName: "pin-4")]
        pinImageView.animationRepeatCount = 1
        pinImageView.animationDuration = 0.85
        pinImageView.startAnimating()
            print("sd");
    }
    func delay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // your code here
            closure()
        }     }
    
    
    @IBAction func bookTripBtnAct(_ sender: UIButton) {
        
        if sender.tag == 0 {
            print("Book now")
        }else if sender.tag == 1{
            print("Book Later")
        }else {
            print("Open Fav List")
        }
    }

}
