//
//  File.swift
//  BucketList
//
//  Created by Андрей Коноплев on 16.01.2023.
//

import MapKit
import SwiftUI

struct Location1: Identifiable {
    let id = UUID()
    let name: String
    let coordonate: CLLocationCoordinate2D
}

struct MapView: View {

    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    let locations = [
        Location1(name: "Buckingham Palace", coordonate: .init(latitude: 51.501, longitude: -0.141)),
        Location1(name: "Tower of London", coordonate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]


    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) {
                location in

                MapAnnotation(coordinate: location.coordonate) {
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .navigationTitle("Map")
        }
    }
}
