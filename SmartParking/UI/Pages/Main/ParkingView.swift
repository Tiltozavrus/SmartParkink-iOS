//
//  ParkingView.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import SwiftUI
import MapKit

protocol Park: Identifiable {
    var workLoad: Workload {get}
    var addres: String {get}
}

struct ParkingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var parkBookingObservable: ParkBookingObservable
    @EnvironmentObject var userObservabe: UserObserved
    @EnvironmentObject var locationsObservable: ParkingLocationsObserved
    
    var park: Location
    
    var body: some View {
        VStack {
            ParkingPlaceView(park: park)
            Button(
                action: {
                    if let userId = userObservabe.user?._id {
                        parkBookingObservable.bookPlace(userID: userId.intValue, location: park)
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Забронировать")
                    .padding()
                    .foregroundColor(.white)
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(Font.headline.weight(.bold))
                    .background(Color.SPBlue)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.SPBlue, lineWidth: 4)
                    )
                }
            )
            .padding()
            .disabled(parkBookingObservable.parkBooking != nil)
            
            Spacer()
        }
    }
}

struct ParkingPlaceView<ParkLocation: Park>: View {
    var park: ParkLocation
    
    var body: some View {
        HStack {
            VStack(spacing: 1) {
                Image("location-big")
                
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.SPDarkBlue)
            }
            VStack(spacing: 10) {
                Text(park.addres)
                    .foregroundColor(.gray)
                    .font(.custom("", size: 18))
                Text(workLoadToText(workLoad: park.workLoad))
                    .foregroundColor(.gray)
                    .font(.custom("", size: 14))
            }
        }
    }
}

func workLoadToText(workLoad: Workload) -> String {
    switch workLoad {
    case .small:
        return "Маленькая загруженность"
    case .medium:
        return "Средняя загруженность"
    case .large:
        return "Очень загруженно"
    }
}

struct ParkingView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingView(
            park: Location(
                id: 1,
                workLoad: .small,
                coordinate: CLLocationCoordinate2D(),
                addres: "Ул Ленина д 12",
                places: []
            )
        ).environmentObject(ParkBookingObservable()).environmentObject(UserObserved()).environmentObject(ParkingLocationsObserved())
    }
}
