
//
//  MapKitAuth.swift
//  LeftIt
//
//  Created by Emanuele Di Pietro on 21/03/24.
//

import Foundation
import SwiftUI
import MapKit

final class MapKitAuth: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?

    var mapRegion = MKCoordinateRegion()

    static let shared = MapKitAuth()

    var binding: Binding<MKCoordinateRegion> {
            Binding {
                self.mapRegion
            } set: { newRegion in
                self.mapRegion = newRegion
            }
        }

    
    func checkIfLocationIsEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                locationManager = CLLocationManager()
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                locationManager!.delegate = self
            } else {
                print("Show an alertletting them know this is off")
            
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task {
            let previousAuthorizationStatus = manager.authorizationStatus
            manager.requestAlwaysAuthorization()
            if manager.authorizationStatus != previousAuthorizationStatus {
                checkLocationAuthorization()
            }
        }
    }

    private func checkLocationAuthorization() {
            guard let location = locationManager else {
                return
            }

            switch location.authorizationStatus {
            case .notDetermined:
                location.requestWhenInUseAuthorization()
                print("Location authorization is not determined.")
            case .restricted:
                print("Location is restricted.")
            case .denied:
                print("Location permission denied.")
            case .authorizedAlways, .authorizedWhenInUse:
                if let location = location.location {
                    mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                }

            default:
                break
            }
        }
}
