//
//  MapView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 14.04.2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    
    var city: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                // Handle error
                return
            }
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: false)
            
        }
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let currentRegion = view.region
        let currentCoordinate = currentRegion.center
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)) { placemarks, error in
            guard let placemark = placemarks?.first, let city = placemark.locality else {
                // Handle error
                return
            }
            guard city != self.city else {
                return
            }
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(self.city) { placemarks, error in
                guard let placemark = placemarks?.first, let location = placemark.location else {
                    // Handle error
                    return
                }
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                view.setRegion(region, animated: true)
            }
        }
    }

}

