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
    var id : String!
    var title: String?
    init(coord : CLLocationCoordinate2D,id : String , title : String? ) {
        self.coordinate = coord
        self.id  = id
        self.title = title 
    }
    
    
    
}
