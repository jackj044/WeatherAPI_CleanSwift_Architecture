//
//  LocationManager.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.
//

import CoreLocation

final class LocationHelper: NSObject {
    
    static let shared = LocationHelper()
    
    private let locationHelper = CLLocationManager()
    
    var getUpdatedLocation: ((CLLocationCoordinate2D?) -> Void)?
    
    private override init() {
        
        super.init()
        locationHelper.delegate = self
        locationHelper.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocationPermission() {
        locationHelper.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationHelper.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationHelper.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate Methods

extension LocationHelper: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location permission granted.")
            startUpdatingLocation()
        case .denied, .restricted:
            print("Location permission denied.")
            DispatchQueueMain.async { [weak self] in
                self?.getUpdatedLocation?(nil)
            }
            stopUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Updated location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            
            getUpdatedLocation?(location.coordinate)
            locationHelper.stopUpdatingLocation()
            locationHelper.delegate = nil;
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed with error: \(error.localizedDescription)")
        getUpdatedLocation?(nil)
    }
}
