//
//  Auth.swift
//  SmartParking
//
//  Created by Даня Демин on 18.05.2022.
//

import Foundation

open class Auth {
    public static var token: String = ""
    public static var refreshToken: String = ""
    
    public static func setToken(token: String) {
        self.token = token
        SwaggerClientAPI.customHeaders.updateValue("Bearer \(token)", forKey: "Authorization")
    }
}
