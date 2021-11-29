//
//  AppStore.swift
//  SmartParking
//
//  Created by Даня Демин on 27.11.2021.
//

import Foundation

final class Store: ObservableObject {
    @Published var state: AppState
    
    init(state: AppState) {
        self.state = state
    }
}
