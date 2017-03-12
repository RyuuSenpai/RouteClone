//
//  GetLocationName.swift
//  ibdaa-app
//
//  Created by Killvak on 06/03/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class GetLocationTitle  {
    
    private static let _getLocation = GetLocationTitle()
    private init() {}
    static var getLocation : GetLocationTitle {
        return _getLocation
    }
    
    
    func cv(lat : Double , long : Double ) -> String{
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: long, longitude: lat)
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
        })
       return _locationName
    }
    
    
    
    func animateImage(image: UIImageView , imageArray : [UIImage] , duration: Double) {
        
        image.animationImages = imageArray
        image.animationRepeatCount = 0
        image.animationDuration = duration
        image.startAnimating()
        print("sd");
    }
    
    func stopPinAnimation(image: UIImageView) {
        
        image.stopAnimating()
    }

    
    
}
