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
    
    var deletThisShit = [AnnotationsClass]()
    var currentAnnotations = [AnnotationsClass]()
    var serverData = [GeoModel]()
    let locationManager = CLLocationManager()
     var userPickedLocation : CLLocationCoordinate2D?
    private      var userLocation : CLLocationCoordinate2D?

   var mapViewIsZoomedIN = true
    var mapViewIsZoomedINOnce = true
    var isObserving = false
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
    

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.observer()
    }
    func observer() {
        guard !isObserving else {
            return
        }
        self.isObserving = true

       _ =  ref?.child("Requests").observeSingleEvent(of: .value, with: { (snapshot) in


        
//        })
//        dataObserver = ref?.child("Requests").observe(.value, with: { (snapshot) in
            
            guard  snapshot.value != nil  else {
                return
            }
            
            for child in snapshot.children {
                //                print("That i the child \(child)")
                let snap = child as! FIRDataSnapshot //each child is a snapshot
                let dataSnap = snap.value as? [String:AnyObject]
                //                print("That i the child 2  \(dataSnap)")
                //                DispatchQueue.main.async {
                //                    self.removeAllAnnotations()
                //                }
                
                //                print("that is the name \(dataSnap?["name"] as! String)")
                guard let name = dataSnap?["name"] as? String ,  let lat = dataSnap?["latitude"] as? Double , let long = dataSnap?["longitude"] as? Double  , let location = self.userPickedLocation else {
                    return }
                //                print("that is my name : \(name) , and that is lat : \(lat) and that is long : \(long)")
                let geoData = GeoModel(name: name , lat: lat , long: long)
                
                let coordinate1 = CLLocation(latitude: location.latitude, longitude: location.longitude)
                let coordinate2 = CLLocation(latitude: lat, longitude: long)
                //Decalare distanceInMeters as global variables so that you can show distance on subtitles
                let distanceInMeters = coordinate1.distance(from: coordinate2)
                print("that city \(geoData.name) is the distance : \(distanceInMeters)")
                if distanceInMeters <= 5000 && geoData.name != "102"  {
                    print("INRANGE: Annotations in range : \(geoData.name) with distnace : \(distanceInMeters)")
                    let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    let x = AnnotationsClass( coord: coordinates , id : geoData.name , title : "\(distanceInMeters) meter" )
//
                        self.serverData.append(geoData)
                        self.currentAnnotations.append(x)
                        self.mapView.addAnnotation(x)
                }else {
                    print("OutRANGE: Annotations in range : \(geoData.name) with distnace : \(distanceInMeters)")
                    print("that is the annotation Number : \(self.mapView.annotations .count)")
                }
            }
        self.isObserving = false
        })
    }
    
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
           userPickedLocation = CLLocationCoordinate2D(latitude: y.latitude, longitude: y.longtiude)
        self.mapViewIsZoomedIN = false
        delay(delay: 2.0){
            self.mapViewIsZoomedIN = true
            self.animateImage()
//            self.removeAllAnnotations()
            self.ref?.child("Requests").child("102").setValue(self.dict(data: y))
            return
            }
        }
        self.removeAllAnnotations()
 self.observer()
//        geoFire.setLocation(CLLocation(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude), forKey: "firebase-hq") { (error) in
//            if (error != nil) {
//                print("An error occured: \(error)")
//            } else {
//                print("Saved location successfully!")
//            }
//        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "Field"
        guard annotation is AnnotationsClass else {    return nil        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        if annotationView != nil {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func removeAllAnnotations() {
        if  self.mapView.annotations.count >= 1 {
            self.mapView.removeAnnotations(self.mapView.annotations)
            print("that is the map Annotation Real Data  \(self.mapView.annotations)")
        }
//        if self.currentAnnotations.count <= 0 {
//             self.mapView.removeAnnotations(self.currentAnnotations)
//            
//        }else {
//            print("7amada")
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
//        print("that is the server data : 2 \(self.serverData)")
//        if sender.tag == 0 {
//            print("Book now")
//        }else if sender.tag == 1{
//            print("Book Later")
//        }else {
//            print("Open Fav List")
//        }
        print("that is the annotation Number : \(self.mapView.annotations .count)")

//      self.removeAllAnnotations()
    }

}
