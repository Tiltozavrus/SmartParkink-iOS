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
    var id: String
    var userId: String
    var parkId: String
    var location: Location
    var place: Place
    var bookingStartTime: Date
    var bookingEndTime: Date
}

struct Place {
    var id: String
    var name: String
}

class ParkBookingObservable: ObservableObject {
    @Published var parkBooking: ParkBooking? = nil
    
    func getBookingForUser(userID: String) {
        // Put Some logic here
    }
    
    func bookPlace(userID: String, parkId: String) {
        parkBooking =
            ParkBooking(
                id: "mock_id",
                userId: userID,
                parkId: parkId,
                location: Location(
                    id: UUID(),
                    workLoad: .small,
                    coordinate: CLLocationCoordinate2D(latitude: 55.897778, longitude: 37.586944),
                    addres: "Ул Ленина д 12"
                ),
                place: Place(id: "mock_id", name: "A3"),
                bookingStartTime: Date.init(),
                bookingEndTime: Date.init().addingTimeInterval(5*60)
            )
    }
    
    func bookPlace(userID: String, location: Location) {
        parkBooking =
            ParkBooking(
                id: "mock_id",
                userId: userID,
                parkId: location.id.uuidString,
                location: location,
                place: Place(id: "mock_id", name: "A3"),
                bookingStartTime: Date.init(),
                bookingEndTime: Date.init().addingTimeInterval(5*60)
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
    
    func cancelBook(userID: String, parkID: String) {
        parkBooking = nil
    }
}
