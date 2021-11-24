//
//  ContentView.swift
//  SmartParking
//
//  Created by Даня Демин on 21.11.2021.
//

import SwiftUI
import CoreData

extension Color {
    public static let SPBlue = Color.init(red: 0, green: 49/255, blue: 152/255)
}

struct ContentView: View {
    var body: some View {
        StartPage()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
