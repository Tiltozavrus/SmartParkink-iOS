//
//  JWT.swift
//  SmartParking
//
//  Created by Даня Демин on 19.05.2022.
//

import Foundation
import JWTDecode

public struct PayloadModel {
    var userId: Int
    var role: String
    
    // Init from Any? as NSDictionary
    init?(from: Any?) {
        if let dict = from as? NSDictionary {
            if let userId = dict.value(forKey: "userId") as? Int {
                self.userId = userId
            } else {
                return nil
            }
            
            if let role = dict.value(forKey: "role") as? String {
                self.role = role
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

public extension JWT {
    var payload: PayloadModel? {
        if let claim = claim(name: "payload").rawValue {
            return PayloadModel.init(from: claim)
        }
        return nil
    }
}
