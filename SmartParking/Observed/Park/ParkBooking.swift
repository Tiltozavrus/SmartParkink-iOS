//
//  ParkBooking.swift
//  SmartParking
//
//  Created by Даня Демин on 30.11.2021.
//

import Foundation
import MapKit
import UIKit

struct ParkBooking {
    var id: Int
    var userId: Int
    var parkId: Int
    var location: Location
    var place: Place
    var bookingStartTime: Date
    var bookingEndTime: Date
}

struct Place {
    var id: Int
    var name: String
}

class ParkBookingObservable: ObservableObject {
    @Published var parkBooking: ParkBooking? = nil
    
    func getBookingForUser() {
//        ParkingAPI.parkingController_5(
//            completion: {
//                resp, err in
//                if let err = err {
//                    print(err)
//                    return
//                }
//
//                if let resp = resp {
//                    self.parkBooking = ParkBooking.init(
//                        id: resp._id.intValue,
//                        userId: resp.userId.intValue,
//                        parkId: 0,
//                        location: location,
//                        place: Place.init(id: resp., name: <#T##String#>),
//                        bookingStartTime: resp.from,
//                        bookingEndTime: resp.to
//                    )
//                }
//            }
//        )
    }
    
    func bookPlace(userID: Int, parkId: Int) {
//
    }
    
    func bookPlace(userID:  Int, location: Location) {
        let now = Date.init(timeIntervalSinceNow: 0)
        ParkingAPI.parkingController_4(
            body: CreateReservePlaceReq.init(from: now, to: now.addingTimeInterval(5*60)),
            placeId: Decimal(location.places.first!.id),
            completion: {
                resp, err in
                if let err = err {
                    print(err)
                    return
                }
                
                if let resp = resp {
                    self.parkBooking = ParkBooking.init(
                        id: resp._id.intValue,
                        userId: resp.userId.intValue,
                        parkId: location.id,
                        location: location,
                        place: location.places.first!,
                        bookingStartTime: resp.from,
                        bookingEndTime: resp.to
                    )
                }
            }
        )
    }
    
    func generateQrCode() -> UIImage? {
        if parkBooking == nil {
            return nil
        }
        
        let myString = "https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley"
        // Get data from the string
        let data = myString.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    func cancelBook(userID: Int, parkID: Int) {
        ParkingAPI.parkingController_6(
            completion: {
                _, err in
                self.parkBooking = nil
                if let err = err?.asAFError {
                    print(err)
                    return
                }
            }
        )
    }
}
