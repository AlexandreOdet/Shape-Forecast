//
//  FindLocationViewController.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import MapKit

protocol FindLocationViewControllerOutput: class {
    func viewIsReady()
    func locationSelected(at coordinate: CLLocationCoordinate2D)
}

final class FindLocationViewController: UIViewController, Reachable {
    
    private lazy var mapView: MKMapView = MKMapView(frame: .zero)
    
    var output: FindLocationViewControllerOutput!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(findLocation(_:)))
        mapView.addGestureRecognizer(gesture)

        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unblurView()
        mapView.removeAnnotations(mapView.annotations)
    }
    
    @objc
    private func findLocation(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: mapView)
        //Convert point into CLLocationCoordinate2D.
        let coordinates = mapView.convert(point, toCoordinateFrom: mapView)
        output.locationSelected(at: coordinates)
    }
}

extension FindLocationViewController: FindLocationPresenterOutput {
    func addAnnotation(at coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func blurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    func unblurView() {
        for subview in view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
}
