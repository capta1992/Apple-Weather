//
//  LocationService.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/6/23.
//

import Foundation
import CoreLocation

protocol LocationService {
    func currentlocation() -> Location?
}

class LocationManager: NSObject, LocationService, CLLocationManagerDelegate {
    private var curent: Location? = nil
    private let manger = CLLocationManager()
    
    override init() {
        super.init()
        manger.delegate = self
        manger.requestWhenInUseAuthorization()
    }
    
    func currentlocation() -> Location? {
        guard let current = curent else {
            if CLLocationManager.locationServicesEnabled() {
                manger.requestLocation()
                return manger.location?.coordinate.location
            }
            return nil
        }
        return current
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        curent = currentLocation.coordinate.location
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension CLLocationCoordinate2D {
    var location: Location {
        .init(lat: latitude, lon: longitude)
    }
}
