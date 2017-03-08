//
//  RideHandler.swift
//  ibdaa-app
//
//  Created by Killvak on 26/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RideHandler: NSObject {

    private static let _instance = RideHandler()
    weak var delegate : RidesController?
    private override init() {} 
    var rider = "requestRide@test.com"
    var driver = "driver@test.com"
    
    var rider_id = "rider1001"
    var driver_id = "driver1001"

    static var Instance : RideHandler {
        return _instance
    }
    
    func requestRide(lat : Double , lang : Double) {
        let data : Dictionary<String , Any> = [ Constants.NAME   : rider, Constants.LATITUDER : lat , Constants.LONGITUDE : lang]
        
        DBProvider.Instance.requestsFirebaseRef.child("101").setValue(data)
    }
    
    
    
    func observeMessagesForDriver() {
        
        
        DBProvider.Instance.requestsFirebaseRef.observe(.childAdded, with: { (snapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let lat = data[Constants.LATITUDER] as? Double ,let long = data[Constants.LONGITUDE] as? Double {
                    
                    self.delegate?.acceptRide(lat: lat, long: long)
                }
            }
            
        })
            }
    
}
