//
//  UserObserved.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import Foundation

struct User {
    var id: String
    var phoneNumber: String
    var firstName: String
    var secondName: String
    var profileImageUrl: String?
}

class UserObserved: ObservableObject {
    @Published var user: User?
    
    func getUser(id: String) {
        if(id == "mock_user_id") {
            user = User(id: "mock_user_id", phoneNumber: "9199138679", firstName: "Даниил", secondName: "Демин")
        }
    }
}
