//
//  AccessToken.swift
//  Bite About It
//
//  Created by Hector Matos on 9/12/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct AccessToken {
    let token: String
    let expiration: Date
    
    enum Keys: String {
        case token
        case expiration
    }
    
    var isValid: Bool {
        return Date() < expiration
    }
    
    var dataValue: Data? {
        return try? JSON([
            Keys.token.rawValue : token,
            Keys.expiration.rawValue : FormatterCache.shared.accessTokenExpirationFormatter.string(from: expiration)
            ]).rawData()
    }
    
    init(token: String, expiration: Date) {
        self.token = token
        self.expiration = expiration
    }
    
    init?(keychainData: Data?) {
        guard let data = keychainData else { return nil }
        
        let json = JSON(data: data)
        if json.type == .dictionary {
            self.token = json[Keys.token.rawValue].stringValue
            self.expiration = FormatterCache.shared.accessTokenExpirationFormatter.date(from: json[Keys.expiration.rawValue].stringValue) ?? Date()
        } else {
            return nil
        }
    }
}
