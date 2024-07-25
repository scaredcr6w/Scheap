//
//  StoreMapViewModel.swift
//  Scheap
//
//  Created by Anda Levente on 25/07/2024.
//

import Foundation
import CoreLocation

enum LocationAuthorizationStatus {
    case restricted
    case denied
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .restricted:
            return "Korlátozott hozzáférés a helymeghatározáshoz."
        case .denied:
            return "Hozzáférés megtagadva."
        case .unknown:
            return "Ismeretlen hiba lépett fel."
        }
    }
}


final class StoreMapViewModel : NSObject, CLLocationManagerDelegate, ObservableObject {
    var userLocation: CLLocationCoordinate2D?
    @Published var locationAuthorizationStatus: LocationAuthorizationStatus?
    var manager = CLLocationManager()
    
    func checkAuthorization() {
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            locationAuthorizationStatus = LocationAuthorizationStatus.restricted
        case .denied:
            locationAuthorizationStatus = LocationAuthorizationStatus.denied
        case .authorizedAlways:
            userLocation = manager.location?.coordinate
        case .authorizedWhenInUse:
            userLocation = manager.location?.coordinate
        @unknown default:
            locationAuthorizationStatus = LocationAuthorizationStatus.unknown
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first?.coordinate
    }
}
