//
//  CitiesMapViewController.swift
//  VIPER_Example
//
//  Created by Malik Usman on 14/05/2019.
//  Copyright © 2019 Usman. All rights reserved.
//

import Foundation
import MapKit
import Presentr
import UIKit

class CitiesMapViewController: BaseViewController {
    // MARK: IBOulets
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var mapView: MKMapView!
    
    // MARK: Properties
    
    var presenter: CitiesMapPresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapAnnoations()
    }
    
    // MARK: - Function
    
    private func setupMapAnnoations() {
        mapView.addAnnotations(presenter?.getMapviewAnnotations() ?? [])
        let latDelta: CLLocationDegrees = 12
        let lonDelta: CLLocationDegrees = 12
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: mapView.annotations[0].coordinate, span: span)
        mapView.setRegion(region, animated: false)
    }
}

extension CitiesMapViewController: CitiesMapView {
    // MARK: - Function
    
    func showLoader() {
        activityIndicator.startAnimating()
    }
    
    // MARK: - Function
    
    func hideLoader() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Function
    
    func onResponse(response: ForecastResponseModel) {
        showAlertWith(message: response.currently?.summary ?? "") { _ in
        }
    }
    
    // MARK: - Function
    
    func onFailure(error: Error) {
        showAlertWith(message: error.localizedDescription) { _ in
        }
    }
}

// MARK: - Delegate

extension CitiesMapViewController: MapAnnoationDelegate {
    func annotationDidTapped(coordinates: CLLocationCoordinate2D?) {
        presenter?.getCityForecast(latitude: coordinates?.latitude ?? 0.0, longitude: coordinates?.longitude ?? 0.0)
    }
}

// MARK: - Delegate

extension CitiesMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MapAnnotationView.reuseIdentifier)
        if annotationView == nil {
            annotationView = MapAnnotationView(annotation: annotation, reuseIdentifier: MapAnnotationView.reuseIdentifier)
            (annotationView as! MapAnnotationView).delegate = self
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
