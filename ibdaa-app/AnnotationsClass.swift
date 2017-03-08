//
//  AnnotationsClass.swift
//  Pods
//
//  Created by Macbook Pro on 3/8/17.
//
//

import Foundation
import MapKit

class AnnotationsClass : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coord : CLLocationCoordinate2D) {
        self.coordinate = coord
    }
    
    
    
}
