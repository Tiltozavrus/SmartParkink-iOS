//
//  HomeView.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import SwiftUI
import MapKit

struct Mark: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct HomeView: View {
    @State var showPark: Bool = false
    @State private var locations: [Mark] = [
        Mark(coordinate: CLLocationCoordinate2D(latitude: 55.897778, longitude: 37.586944))
    ]
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
//        Map(coordinateRegion: $region)
        Map(coordinateRegion: $region, annotationItems: locations) {
            location in
            MapAnnotation(
                coordinate: location.coordinate,
                anchorPoint: CGPoint(x: 0.5, y: 0.7)
                ) {
                VStack {
                    NavigationLink(
                        destination: Text("Destination"),
                        isActive: $showPark,
                        label: {
                            LocationImage()
                                .onTapGesture {
                                    showPark.toggle()
                                }
                        })
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
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
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
