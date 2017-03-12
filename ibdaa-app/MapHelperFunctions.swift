//
//  MapHelperFunctions.swift
//  ibdaa-app
//
//  Created by Macbook Pro on 3/9/17.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import CoreLocation

class MapHelperFunctions : NSObject  {
    
    private static let _MapHelperFunctions = MapHelperFunctions()
    
    static var mapHelperClass : MapHelperFunctions {
        return _MapHelperFunctions
    }
    /*

 
 */
   static  func cv(location : CLLocation,completed : @escaping (String)->()) {
        let geoCoder = CLGeocoder()
        var _locationName = ""
    var _city = ""
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
                _city = city
            }
            if let zip = addressDict["ZIP"] as? String {
                print(zip)
            }
            if let country = addressDict["Country"] as? String {
                print(country)
            }
            
            DispatchQueue.main.async {
                completed(_locationName + " , " + _city)
                print("that is the cityName  : \(_locationName)")
            }
        })
        
    }
}
