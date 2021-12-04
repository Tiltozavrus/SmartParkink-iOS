//
//  HomeView.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import SwiftUI
import MapKit

enum Workload {
    case small
    case medium
    case large
}

struct Mark: Park {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let workLoad: Workload
    let addres: String
}

struct HomeView: View {
    @EnvironmentObject var locationsObservable: ParkingLocationsObserved
    @EnvironmentObject var parkBookinObservable: ParkBookingObservable
    @EnvironmentObject var userObservable: UserObserved
   
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 55.897778,
                longitude: 37.586944
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1
            )
        )
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locationsObservable.locations) {
            location in
            MapAnnotation(
                coordinate: location.coordinate
                ) {
                VStack {
                    NavigationLink(
                        destination: ParkingView(park: location)
                            .environmentObject(userObservable)
                            .environmentObject(parkBookinObservable)
                    ) {
                        LocationImage(workLoad: location.workLoad)
                    }
                }
            }
        }.onAppear{
            locationsObservable.getLocations()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(ParkingLocationsObserved())
                .environmentObject(ParkBookingObservable())
                .environmentObject(UserObserved())
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Text("SmartPark")
                                .font(.custom("Comfortaa-VariableFont_wght", size: 36))
                                .foregroundColor(.SPBlue)
                            LoadingLine(withAnimation: false).frame(width: 100, height: 100, alignment: .center)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
