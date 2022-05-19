//
//  UserObserved.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import Foundation

struct User {
    var id: Int
    var phoneNumber: String
    var firstName: String
    var secondName: String
    var profileImageUrl: String?
}

class UserObserved: ObservableObject {
    @Published var user: GetUsersResp?
    
    func getUser(id: Int) {
        print("get user with id \(Decimal(id))")
        AuthAPI.authController_1(
            _id: Decimal(id),
            completion: {
                resp, err in
                if let err = err {
                    print(err)
                    return
                }
                
                self.user = resp
            }
        )
    }
}
