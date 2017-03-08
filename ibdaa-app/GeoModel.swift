//
//  GeoModel.swift
//  ibdaa-app
//
//  Created by Macbook Pro on 3/8/17.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation

class GeoModel : NSObject {
    
    
    var _name : String?
    var _latitude : Double?
    var _longitude : Double?
    
    var name : String {
        guard let name  = _name else {
            return "invalid name"
        }
        return name
    }
    
    var latitude : Double {
        guard let lat  = _latitude else {
            return 00
        }
        return lat
    }
    var longtiude : Double {
        guard let long  = _longitude else {
            return 00
        }
        return long
    }
    
    
    init(name : String , lat : Double,long : Double) {
        self._name = name
        self._latitude = lat
        self._longitude = long
    }
}
