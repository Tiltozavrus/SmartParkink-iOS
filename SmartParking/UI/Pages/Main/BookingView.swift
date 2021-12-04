//
//  BookingView.swift
//  SmartParking
//
//  Created by Даня Демин on 30.11.2021.
//

import SwiftUI

struct BookingView: View {
    @EnvironmentObject var bookingObserved: ParkBookingObservable
    
    var body: some View {
        VStack {
            if let park = bookingObserved.parkBooking {
                ParkingPlaceView(park: park.location)
                
                Text("Место \(park.place.name)")
                    .font(.custom("", size: 36))
                    .foregroundColor(.gray)
                
                if let qrCode = bookingObserved.generateQrCode() {
                    Image(uiImage: qrCode)
                } else {
                    Text("nil")
                }
                
                Text("Забронировано на 5 минут")
                    .font(.custom("", size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                Text("Поднесите QR-код к считывающему устройству на въезде парковки")
                    .font(.custom("", size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            } else {
                Spacer()
                Text("На данный момент нет действительных бронирований")
                    .font(.custom("", size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
            .environmentObject(ParkBookingObservable())
    }
}
