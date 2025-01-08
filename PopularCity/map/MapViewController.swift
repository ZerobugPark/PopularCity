//
//  MapViewController.swift
//  PopularCity
//
//  Created by youngkyun park on 1/8/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    
    
    
    @IBOutlet var seg: UISegmentedControl!
    var annotations: [MKPointAnnotation] = []
    let emptyList = RestaurantList().restaurantArray
    var restaurantList: [Restaurant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mapView.delegate = self
        
        restaurantList = emptyList
        configureMapView()
        let title: [String] = ["모두", "국내", "해외"]
        for i in 0...2{
            seg.setTitle(title[i], forSegmentAt: i)
        }
        seg.selectedSegmentIndex = 0
        
    }
    
    
    func configureMapView() {
        
        
        for i in 0..<restaurantList.count {
            let latitude = restaurantList[i].latitude
            let longitude = restaurantList[i].longitude
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = restaurantList[i].name
            mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 210, longitudinalMeters: 210)
            annotations.append(annotation)
            
        }
        
        
        mapView.addAnnotations(annotations)
        mapView.showsUserLocation = true
        
    }
    
    
    
    @IBAction func testSeg(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            restaurantList = emptyList
            print("1")
        case 1:
            restaurantList = emptyList.filter {$0.category == "양식"}
            print("2")
        default:
            restaurantList = emptyList.filter {$0.category == "한식"}
            print("3")
            
        }
        
        
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
        configureMapView()
        
    }
    
    @IBAction func filterBtnTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        
        
        let test1 = UIAlertAction(title: "전체", style: .default, handler: { (ACTION:UIAlertAction) in
            self.restaurantList = self.emptyList
            self.mapView.removeAnnotations(self.annotations)
            self.annotations.removeAll()
            self.configureMapView()
        })
        let test2 = UIAlertAction(title: "한식", style: .default, handler:{ (ACTION:UIAlertAction) in
            self.restaurantList = self.emptyList.filter {$0.category == "한식"}
            self.mapView.removeAnnotations(self.annotations)
            self.annotations.removeAll()
            self.configureMapView()
        })
        let test3 = UIAlertAction(title: "양식", style: .default, handler: { (ACTION:UIAlertAction) in
            self.restaurantList = self.emptyList.filter {$0.category == "양식"}
            self.mapView.removeAnnotations(self.annotations)
            self.annotations.removeAll()
            self.configureMapView()
        })
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(test1)
        alert.addAction(test2)
        alert.addAction(test3)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
