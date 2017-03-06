//
//  ViewController.swift
//  Auto Complete
//
//  Created by Agus Cahyono on 11/11/16.
//  Copyright © 2016 balitax. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapsVC: UIViewController, CLLocationManagerDelegate , GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {
    
    // OUTLETS
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var mapViewThatContainThe2Buttons: UIView!
    
    // VARIABLES
    var locationManager = CLLocationManager()
    
    // test
    var placesClient: GMSPlacesClient!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.googleMapsView.isHidden = true
        self.mapViewThatContainThe2Buttons.isHidden = true
        self.googleMapsView.alpha = 0
        self.mapViewThatContainThe2Buttons.alpha = 0
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        placesClient = GMSPlacesClient.shared()

        initGoogleMaps()
    }
    
    func initGoogleMaps() {
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.googleMapsView.camera = camera
        
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.settings.myLocationButton = true
        
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    }
    
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        print("thta is the coordinates \( (location?.coordinate.latitude)!) : %@@ : \((location?.coordinate.longitude)!)")

        
    }
    
    // MARK: GMSMapview Delegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapsView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        self.googleMapsView.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
        }
 
    }
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        self.googleMapsView.camera = camera
        self.dismiss(animated: true, completion: nil) // dismiss after select place
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) // when cancel search
    }
    
    
    @IBOutlet weak var heightttt: NSLayoutConstraint!
    
    
    var center = ""
    
    
    
    @IBAction func openSearchAddress(_ sender: UIButton) {
        
        self.heightttt.constant = 0
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)

        self.googleMapsView.isHidden = false
        self.mapViewThatContainThe2Buttons.isHidden = false

    }
 
    @IBAction func selectMapCenterCoordinate(_ sender: UIButton) {
        print("thta is the coordinates \(googleMapsView.camera.target)")
//        print("thta is the coordinates \(googleMapsView.placeholderText.self    )")
        cv()
        
        
//        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            
//            
//            if let placeLikelihoodList = placeLikelihoodList {
//                let place = placeLikelihoodList.likelihoods.first?.place
//                if let place = place {
//                    
//                    print("Pick Place place.name: \(place.name)")
//                }
//            }
//        })
        
        

    }

    
    @IBAction func manuallyPickupLocation(_ sender: UIButton) {
        self.googleMapsView.isHidden = false
        self.mapViewThatContainThe2Buttons.isHidden = false
        UIView.animate(withDuration: 2.5, animations: {
            self.googleMapsView.alpha = 1.0
            UIView.animate(withDuration: 4.5, animations: {
            self.mapViewThatContainThe2Buttons.alpha = 1.0
            })
        })
        self.heightttt.constant = 0

            }
//Test 
    func cv() {
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: googleMapsView.camera.target.latitude, longitude: googleMapsView.camera.target.longitude)
    var _locationName = ""
    geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
    guard let addressDict = placemarks?[0].addressDictionary else {
    return
    }
    
    // Print each key-value pair in a new row
    addressDict.forEach { print($0) }
    
    // Print fully formatted address
    if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
    print(formattedAddress.joined(separator: ", "))
    }
    
    // Access each element manually
    if let locationName = addressDict["Name"] as? String {
    print(locationName)
        _locationName = locationName
    }
    if let street = addressDict["Thoroughfare"] as? String {
    print(street)
    }
    if let city = addressDict["City"] as? String {
    print(city)
    }
    if let zip = addressDict["ZIP"] as? String {
    print(zip)
    }
    if let country = addressDict["Country"] as? String {
    print(country)
    }
        
        DispatchQueue.main.async {
            
            print("that is the cityName  : \(_locationName)")
        }
    })
    
    }
  
}

