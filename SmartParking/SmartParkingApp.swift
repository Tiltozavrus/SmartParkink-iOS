//
//  SmartParkingApp.swift
//  SmartParking
//
//  Created by Даня Демин on 21.11.2021.
//

import SwiftUI

@main
struct SmartParkingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
