//
//  ParkingLocationObserved.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import Foundation
import MapKit

struct Location: Park {
    var id: UUID
    
    var workLoad: Workload
    
    var coordinate: CLLocationCoordinate2D
    
    var addres: String
}

class ParkingLocationsObserved: ObservableObject {
    @Published var locations: [Location] = []
    
    func getLocations() {
        locations = [
            Location(
                id: UUID(),
                workLoad: .small,
                coordinate: CLLocationCoordinate2D(latitude: 55.897778, longitude: 37.586944),
                addres: "Ул. Ленина, д 12"
            ),
            Location(
                id: UUID(),
                workLoad: .large,
                coordinate: CLLocationCoordinate2D(latitude: 55.669935, longitude: 37.480300),
                addres: "Ул. Мирэашная д 1337"
            )
        ]
    }
}
