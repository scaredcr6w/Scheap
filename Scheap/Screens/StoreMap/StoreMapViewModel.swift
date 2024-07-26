//
//  StoreMapViewModel.swift
//  Scheap
//
//  Created by Anda Levente on 25/07/2024.
//

import Foundation
import CoreLocation

final class StoreMapViewModel : NSObject, CLLocationManagerDelegate, ObservableObject {
    var userLocation: CLLocationCoordinate2D?
    var manager = CLLocationManager()
    
    func checkAuthorization() {
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            userLocation = manager.location?.coordinate
        case .authorizedWhenInUse:
            userLocation = manager.location?.coordinate
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first?.coordinate
    }
}
