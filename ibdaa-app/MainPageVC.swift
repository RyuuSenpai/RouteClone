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
import FirebaseDatabase
//import Firebase
class MainPageVC: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate , RidesController{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinImageView: UIImageView!
    
    var currentAnnotations = [AnnotationsClass]()
    var serverData = [GeoModel]()
    let locationManager = CLLocationManager()
    private var userLocation : CLLocationCoordinate2D?
   var mapViewIsZoomedIN = true
    var mapViewIsZoomedINOnce = true
    var ref : FIRDatabaseReference?
    var dataObserver : FIRDatabaseHandle?
//    var geoFire : GeoFire!
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
        
        ref = FIRDatabase.database().reference()
//         geoFire = GeoFire(firebaseRef: ref)
         dataObserver = ref?.child("Requests").observe(.value, with: { (snapshot) in
            
            guard  snapshot.value != nil  else {
                return
            }
            
            for child in snapshot.children {
//                print("That i the child \(child)")
                let snap = child as! FIRDataSnapshot //each child is a snapshot
                let dataSnap = snap.value as? [String:AnyObject]
//                print("That i the child 2  \(dataSnap)")

                print("that is the name \(dataSnap?["name"] as! String)")
            }
//            for child in  snapshot.children {
//                 let snap = child as! FIRDataSnapshot //each child is a snapshot
//                let dataSnap = snap.value as? [String:AnyObject]
//                
//                guard let data = dataSnap , let location = self.userLocation else { return }
//                guard let name = data["name"] as? String ,  let lat = data["latitude"] as? Double , let long = data["longitude"] as? Double else { return }
//                
//                let geoData = GeoModel(name: name , lat: lat , long: long)
//                print("That is the name [\(geoData.name)]")
//                
//                let coordinate1 = CLLocation(latitude: location.latitude, longitude: location.longitude)
//                let coordinate2 = CLLocation(latitude: lat, longitude: long)
//                //Decalare distanceInMeters as global variables so that you can show distance on subtitles
//                let distanceInMeters = coordinate1.distance(from: coordinate2)
//                guard distanceInMeters <= 5000 && geoData.name != "102" else { print("1022421412321");return }
//                print("That is the name [\(geoData.name)]")
//                
//                print("that is the data in the server : \(geoData.name) and that is the distnace between :  \(distanceInMeters  )")
//                let x = AnnotationsClass( coord: CLLocationCoordinate2D(latitude: lat, longitude: long))
//                self.mapView.addAnnotation(x)
//                self.serverData.append(geoData)
//  
//            }
            
            
//            let x = snapshot.value as? Dictionary<String,AnyObject>
//   
////            print("that is aswesome : \(x)")
//            
//            guard let data = x , let location = self.userLocation else {
//                return
//            }
////            guard let name = data["name"] as? String ,  let lat = data["latitude"] as? Double , let long = data["longitude"] as? Double else {
////            
////                return
////            }
//            
//            for ( key , data ) in data {
//                print("that is the key : \(key) and that is the value : \(data)")
//                guard let name = data["name"] as? String ,  let lat = data["latitude"] as? Double , let long = data["longitude"] as? Double else {
//                    return
//                }
//
//                let geoData = GeoModel(name: name , lat: lat , long: long)
//                print("That is the name [\(geoData.name)]")
//                
//                let coordinate1 = CLLocation(latitude: location.latitude, longitude: location.longitude)
//                let coordinate2 = CLLocation(latitude: lat, longitude: long)
//                //Decalare distanceInMeters as global variables so that you can show distance on subtitles
//                let distanceInMeters = coordinate1.distance(from: coordinate2)
//                guard distanceInMeters <= 5000 && geoData.name != "102" else { print("1022421412321");return }
//                print("That is the name [\(geoData.name)]")
//                
//                print("that is the data in the server : \(geoData.name) and that is the distnace between :  \(distanceInMeters  )")
//                let x = AnnotationsClass( coord: CLLocationCoordinate2D(latitude: lat, longitude: long))
//                self.mapView.addAnnotation(x)
//                self.serverData.append(geoData)
//                self.currentAnnotations.append(x)
//
//            
//            
//            
//            }
////            print("that is aswesome2 : \(snapshot.value)")

         })
        
//        dataObserver = ref?.child("Requests").observe(.childChanged, with: { (snapshot) in
//            
//            let dataSnap = snapshot.value as? [String:AnyObject]
//            
//            guard let data = dataSnap , let location = self.userLocation else { return }
//            guard let name = data["name"] as? String ,  let lat = data["latitude"] as? Double , let long = data["longitude"] as? Double else { return }
//            
//            let geoData = GeoModel(name: name , lat: lat , long: long)
//            print("That is the name [\(geoData.name)]")
//
//            let coordinate1 = CLLocation(latitude: location.latitude, longitude: location.longitude)
//            let coordinate2 = CLLocation(latitude: lat, longitude: long)
//            //Decalare distanceInMeters as global variables so that you can show distance on subtitles
//            let distanceInMeters = coordinate1.distance(from: coordinate2)
//            guard distanceInMeters <= 5000 && geoData.name != "102" else { print("1022421412321");return }
//            print("That is the name [\(geoData.name)]")
//
//            print("that is the data in the server : \(geoData.name) and that is the distnace between :  \(distanceInMeters  )")
//            let x = AnnotationsClass( coord: CLLocationCoordinate2D(latitude: lat, longitude: long))
//            self.mapView.addAnnotation(x)
//            self.serverData.append(geoData)
//
//        })
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
//
//        let alert = UIAlertController(title: title, message: sms, preferredStyle: .alert)
//        
//        if requestAlive {
//            let accept = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
//                
//                
//            })
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil   )
//            
//            alert.addAction(accept)
//            alert.addAction(cancel)
//        }else {
//            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil   )
//        alert.addAction(ok)
//        }
//        present(alert, animated: true, completion: nil)
    }
    
    
    //@end Protocol
    @IBAction func requestARide(_ sender: Any) {
        RideHandler.Instance.requestRide(lat: self.mapView.centerCoordinate.latitude, lang: mapView.centerCoordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location?.coordinate {
            userLocation = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            guard let userlocation = userLocation else { return }
            if mapViewIsZoomedINOnce {
            let region = MKCoordinateRegionMake(userlocation, MKCoordinateSpanMake(0.01, 0.01))
            //
            mapView.setRegion(region, animated: true)
                self.mapViewIsZoomedINOnce = false
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if  mapViewIsZoomedIN {
            let y = GeoModel(name: "102", lat: self.mapView.centerCoordinate.latitude, long: self.mapView.centerCoordinate.longitude)
//        print("Zoomed in regionDidChangeAnimated \(self.mapView.centerCoordinate) ")
        self.mapViewIsZoomedIN = false
        delay(delay: 2.0){
            self.mapViewIsZoomedIN = true
            self.animateImage()
            return
            }
          self.ref?.child("Requests").child("102").setValue(dict(data: y))
        }
 
//        geoFire.setLocation(CLLocation(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude), forKey: "firebase-hq") { (error) in
//            if (error != nil) {
//                print("An error occured: \(error)")
//            } else {
//                print("Saved location successfully!")
//            }
//        }
    }
    
    func dict(data : GeoModel) -> Dictionary<String,AnyObject> {
        
        return [
            Constants.NAME : data.name as AnyObject,
            Constants.LATITUDER : data.latitude as AnyObject,
            Constants.LONGITUDE : data.longtiude as AnyObject
        ]
        
        
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
        print("that is the server data : 2 \(self.serverData)")
        if sender.tag == 0 {
            print("Book now")
        }else if sender.tag == 1{
            print("Book Later")
        }else {
            print("Open Fav List")
        }
    }

}
