
//
//  BookNowVC.swift
//  ibdaa-app
//
//  Created by Killvak on 01/03/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class BookNowVC: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{
    
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var methoudOfPaying: UILabel!
    @IBOutlet weak var estimatedMoney: UILabel!
    @IBOutlet weak var promoCode: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationName : String?
    var destinationName : String?
    var startCoordinates : CLLocationCoordinate2D?
    var locationManger = CLLocationManager()
    var destinationCoordinates : CLLocationCoordinate2D?
    
    var annoationArray = [AnnotationsClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("that is the navigation Array : \(self.navigationController?.viewControllers)")
        mapView.delegate = self
        if let coorindate = startCoordinates {
            var coordinatedRegion : MKCoordinateRegion!
          coordinatedRegion = MKCoordinateRegionMakeWithDistance(coorindate, 5000, 5000)
             self.addAnnoations(location: CLLocationCoordinate2D(latitude: coorindate.latitude , longitude: coorindate.longitude), id: "green", title: nil)
            if let destCoor = destinationCoordinates {
                self.addAnnoations(location: CLLocationCoordinate2D(latitude: destCoor.latitude , longitude: destCoor.longitude), id: "blue", title: nil)
                
                var navArray:Array = (self.navigationController?.viewControllers)!
                navArray.remove(at: navArray.count-2)
                navArray.remove(at: navArray.count-2)
                self.navigationController?.viewControllers = navArray
            }
            
            mapView.setRegion(coordinatedRegion, animated: true)
            mapView.showAnnotations(annoationArray, animated: true)

        }
    addGestueresToLabels()
    }
    
    func addAnnoations(location : CLLocationCoordinate2D,id:String,title:String?) {
        
        let anno = AnnotationsClass(coord: location, id: id, title: title)
        self.annoationArray.append(anno)
        self.mapView.addAnnotation(anno)

    }
    
    
    func addGestueresToLabels() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.locationLabelAct))
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.methoudOfPayingLabelAct))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.estimatedMoneyLabelAct))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.promoCodeLabelAct))
        
        locationTitle.addGestureRecognizer(tap)
        methoudOfPaying.addGestureRecognizer(tap1)
        estimatedMoney.addGestureRecognizer(tap2)
        promoCode.addGestureRecognizer(tap3)
        
        if let destination = destinationName {
            self.estimatedMoney.text = destination
        }
        if let location = locationName {
            self.locationTitle.text = location
            print("Locantion : \(location)")
        }
    }
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let annoIdentifier = "AnnotationId"
//        var annotationView: MKAnnotationView?
//        
//        if annotation.isKind(of: MKUserLocation.self) {
//            return nil
//        }
//        
//        if  let anno = annotation as? AnnotationsClass {
//            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annoIdentifier)
//            annotationView?.canShowCallout = false
//            annotationView?.image = UIImage(named: "pin.\(anno.id!)")
//            print("that is the image name : \("pin.\(anno.id!)")")
//                    }
//        
//            return annotationView
//            
//        }

    
    
     
     //MARK: - Custom Annotation
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     let reuseIdentifier = "pin"
     var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
     
     if annotationView == nil {
     annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
     annotationView?.canShowCallout = false
     } else {
     annotationView?.annotation = annotation
     }
     
     let customPointAnnotation = annotation as! AnnotationsClass
     annotationView?.image = UIImage(named: "pin.\(customPointAnnotation.id!)")
//        mapView.translatesAutoresizingMaskIntoConstraints = true

     return annotationView
     }

 
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if (annotation is MKUserLocation) {
//            return nil
//        }
//        
//        if (annotation.isKind(of: AnnotationsClass.self)) {
//            let customAnnotation = annotation as? AnnotationsClass
//            mapView.translatesAutoresizingMaskIntoConstraints = false
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationsClass") as MKAnnotationView!
//            
//            if (annotationView == nil) {
////                annotationView = customAnnotation?.annotationView()
//            } else {
////                annotationView.annotation = annotation;
//            }
//            annotationView?.image = UIImage(named: "pin.green")
////            self.addBounceAnimationToView(annotationView)
//            return annotationView
//        } else {
//            return nil
//        }
//    }
//    
    
    func centerMapOnLocation(location: CLLocation) {
        
//        let coordinateRegion = MKCoo
    }
    
    func locationLabelAct() {
        print("Location label")
    }
    
    func methoudOfPayingLabelAct() {
        print("methoudOfPayingLabelAct label")
    }
    func estimatedMoneyLabelAct() {
        print("estimatedMoneyLabelAct label")
let googlemapV = self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapsVC") as! GoogleMapsVC
        googlemapV.userLocation = locationName
        googlemapV.startCoordinates = startCoordinates
        navigationController?.pushViewController(googlemapV, animated: true)
//        self.present(googlemapV, animated: true, completion: nil)

    }
    func promoCodeLabelAct() {
        print("promoCodeLabelAct label")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func bookNowBtnAct(_ sender: UIButton) {
        performSegue(withIdentifier: "closetDriverSegue", sender: self)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
