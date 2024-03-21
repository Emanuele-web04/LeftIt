//
//  MapView.swift
//  LeftIt
//
//  Created by Emanuele Di Pietro on 21/03/24.
//

import SwiftUI
import MapKit
import CoreLocation


struct MapView: View {
    
    @State private var position = MapCameraPosition.region(
        MapKitAuth.shared.mapRegion
    )
    
    @State private var locations = [Location]()
    
    var body: some View {
        MapReader { proxy in
            Map(position: $position) {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = Location(id: UUID(), name: "New Locaton", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
        }
    }
}

#Preview {
    MapView()
}
