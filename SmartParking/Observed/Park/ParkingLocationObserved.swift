//
//  ParkingLocationObserved.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import Foundation
import MapKit

struct Location: Park {
    var id: Int
    
    var workLoad: Workload
    
    var coordinate: CLLocationCoordinate2D
    
    var addres: String
    
    var places: [Place]
}

extension Decimal {
    var locationDegrees: CLLocationDegrees {
        return NSDecimalNumber(decimal: self).doubleValue
    }
    
    var intValue: Int {
        return NSDecimalNumber(decimal: self).intValue
    }
}

class ParkingLocationsObserved: ObservableObject {
    @Published var locations: [Location] = []
    
    @Published var parks: GetParksResp?
    
    func getLocations() {
        self.locations = []
        
        ParkingAPI.parkingController(
            edges: [Edges.parkPlaces, Edges.parkPlacesInfo],
            completion: {
                resp, err in
                if let err = err {
                    print(err)
                    return
                }
                if let resp = resp {
                    for item in resp.items {
                        var workload: Workload = Workload.small
                        if let parkInfos = item.parkPlacesInfo {
                            if let last = parkInfos.last {
                                workload = self.calculateWorkload(item: last)
                            }
                        }
                        
                        let location = Location.init(
                            id: item._id.intValue,
                            workLoad: workload,
                            coordinate: CLLocationCoordinate2D.init(
                                latitude: item.latitude.locationDegrees,
                                longitude: item.longitude.locationDegrees
                            ),
                            addres: item.address,
                            places: (item.parkPlaces != nil) ? self.getPlaces(items: item.parkPlaces!) : []
                        )
                        self.locations.append(location)
                    }
                }
            }
        )
    }
    
    private func calculateWorkload(item: GetParkPlaceInfoResp) -> Workload {
        let workload = item.occupiedSpaces / (item.freeSpaces + item.occupiedSpaces)
        if workload <= 0.25 {
            return Workload.small
        } else if workload < 0.75 {
            return Workload.medium
        } else {
            return Workload.large
        }
    }
    
    private func getPlaces(items: [GetParkPlaceResp]) -> [Place] {
        var places: [Place] = []
        for item in items {
            places.append(Place.init(id: item._id.intValue, name: "A-\(item._id.intValue)"))
        }
        return places
    }
}
