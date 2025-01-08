//
//  MapViewController.swift
//  PopularCity
//
//  Created by youngkyun park on 1/8/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, ObjectSetup {

    
    @IBOutlet var mapView: MKMapView!
    
    
    @IBOutlet var filterBtn: UIButton!
    
    var annotations: [MKPointAnnotation] = []
    let originRestaurantData = RestaurantList().restaurantArray
    var restaurantList: [Restaurant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        restaurantList = originRestaurantData
        
        Setup()

        
    }
    
    func Setup() {
        configureMapView()
        buttonConfig()
        
    }
    
    func buttonConfig() {
        let title = "Filter"
        filterBtn.setTitle(title, for: .normal)
        filterBtn.setTitleColor(.white, for: .normal)
        filterBtn.layer.cornerRadius = 10
        filterBtn.backgroundColor = .lightGray
        
    }
    
    func configureMapView() {
        
        var centerLatitude:Double = 0
        var centerLongitude:Double = 0
        
        for i in 0..<restaurantList.count {
            let latitude = restaurantList[i].latitude
            let longitude = restaurantList[i].longitude
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = restaurantList[i].name
            centerLatitude += latitude
            centerLongitude += longitude
            annotations.append(annotation)
            
        }
        centerLatitude = centerLatitude / Double(restaurantList.count)
        centerLongitude = centerLongitude  / Double(restaurantList.count)
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.addAnnotations(annotations)
        
    }
    
    

    @IBAction func filterBtnTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let restaurants = UIAlertAction(title: "전체", style: .default, handler: { _ in self.filterCategory(category: nil) })
        let koreanFood = UIAlertAction(title: "한식", style: .default, handler:{ _ in self.filterCategory(category: "한식") })
        let westernFood = UIAlertAction(title: "양식", style: .default, handler: { _ in self.filterCategory(category: "양식") })
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(restaurants)
        alert.addAction(koreanFood)
        alert.addAction(westernFood)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    private func filterCategory(category: String?) {
        if let category = category {
            restaurantList = originRestaurantData.filter {$0.category == category}
        } else {
            restaurantList = originRestaurantData
        }
            
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
        configureMapView()
    }
}
