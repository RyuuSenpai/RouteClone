//
//  DBProvider.swift
//  ibdaa-app
//
//  Created by Killvak on 26/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import FirebaseDatabase


class DBProvider {
    
    private static let _instance = DBProvider()
    private init() {}
    static var Instance : DBProvider {
        return _instance
    }
    
    var dbRef : FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var taxiFirebaseRef : FIRDatabaseReference  {
        return dbRef.child(Constants.TAXI)
    }
    
    var reservationFirebaseRef : FIRDatabaseReference  {
        return dbRef.child(Constants.RESERVATIONS)
    }
    var requestsFirebaseRef : FIRDatabaseReference  {
        return dbRef.child(Constants.REQUESTS)
    }
    
}
