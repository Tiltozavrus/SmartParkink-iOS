//
//  AuthObserved.swift
//  SmartParking
//
//  Created by Даня Демин on 27.11.2021.
//

import Foundation
import UserNotifications
import JWTDecode

class AuthObserved: ObservableObject {
    @Published var isLogin: Bool = false
    @Published var phoneNumber: String = ""
    @Published var userData: String = ""
    @Published var isLoading: Bool = false
    @Published var userID: Int = 0
    
    private func getPhoneNumber() -> String {
        return "+7 " + phoneNumber
    }
    
    /// return true is request for get code succesfully sended
    func getCode() -> Bool {
        isLoading = true
        
        AuthAPI.authController_8(
            phone: getPhoneNumber(),
            completion: {
                _code, err in
                if let err = err {
                    print(err)
                }
                if let code = _code {
                    self.sendCode(code: code)
                }
                
            }
        )
        defer {
            self.isLoading = false
        }
        return true
    }
    
    func sendCode(code: String) {
        let content = UNMutableNotificationContent()
        content.title = "Your code \(code)"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        print(code)
    }
    
    func registr() -> Bool {
        isLoading = true
        AuthAPI.authController_0(
            body: CreateUserDto.init(
                phoneNumber: getPhoneNumber(), name: userData
            ),
            completion: {
                resp, err in
                if let err = err {
                    print(err)
                    return
                }
//                self.userID = resp?._id
            }
        )
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
        
        
        AuthAPI.authController_10(
            body: LoginUserDto.init(
                phoneNumber: self.getPhoneNumber(),
                code: code
            ),
            completion: {
                resp, err in
                
                if let err = err {
                    print(err)
                    return
                }
                
                if let resp = resp {
                    Auth.setToken(token: resp.token)
                    if let jwt = try? decode(jwt: resp.token) {
                        if let payload = jwt.payload {
                            self.userID = payload.userId
                        }
                    }
                    
                    
                    self.isLogin = true
                    return
                }
            }
        )
        
        return true
    }
    
    
}
