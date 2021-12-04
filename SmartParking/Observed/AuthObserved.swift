//
//  AuthObserved.swift
//  SmartParking
//
//  Created by Даня Демин on 27.11.2021.
//

import Foundation

class AuthObserved: ObservableObject {
    @Published var isLogin: Bool = false
    @Published var phoneNumber: String = ""
    @Published var userData: String = ""
    @Published var isLoading: Bool = false
    @Published var userID: String = ""
    
    /// return true is request for get code succesfully sended
    func getCode() -> Bool {
        isLoading = true
        defer {
            self.isLoading = false
        }
        return true
    }
    
    func registr() -> Bool {
        isLoading = true
        defer {
            isLoading = false
        }
        return true
    }
    
    /// return true if code valid
    func verifyCode(code: String) -> Bool {
        isLoading = true
        defer {
            isLoading = false
        }
        if(code == "0000") {
            self.isLogin = true
            self.userID = "mock_user_id"
            return true
        }
        return false
    }
    
    
}
