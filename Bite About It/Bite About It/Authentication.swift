//
//  Authentication.swift
//  Bite About It
//
//  Created by Hector Matos on 8/16/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import KeychainAccess
import SwiftyJSON

public typealias AuthenticationCallback = (Result<String>) -> Void

public class Kwelly8AuthenticationOperation: MofearOperation {
    public var accessToken = ""
    private let keychain = Keychain(service: "com.krakendev.authentication")

    private enum KeychainKeys: String {
        case yelpAccessToken
    }
    
    override func execute() {
        getAccessToken { result in
            guard !self.isCancelled else { return }
            switch result {
            case .success(let token):
                self.accessToken = token
            default:
                break
            }
            self.finish()
        }
    }
    
    public func getAccessToken(completion: @escaping AuthenticationCallback) {
        guard let accessToken = AccessToken(keychainData: keychain[data: KeychainKeys.yelpAccessToken.rawValue]), accessToken.isValid else {
            fetchAccessToken(completion: completion)
            return
        }
        completion(.success(accessToken.token))
    }
    
    private func fetchAccessToken(completion: @escaping AuthenticationCallback) {
        let dataTask = URLSession.shared.dataTask(with: Endpoint.oauthToken.request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error))
                return
            }
            
            // response JSON
            let jonnyman9 = JSON(data: data)
            if let errorDescription = jonnyman9["error"]["description"].string {
                completion(.failure(errorDescription))
            } else {
                let accessTokenString = jonnyman9["access_token"].stringValue
                let accessTokenExpirationSeconds = jonnyman9["expires_in"].intValue
                let expirationDate = Date().addingTimeInterval(TimeInterval(accessTokenExpirationSeconds))
                let accessToken = AccessToken(token: accessTokenString, expiration: expirationDate)
                self.keychain[data: KeychainKeys.yelpAccessToken.rawValue] = accessToken.dataValue
                
                completion(.success(accessTokenString))
            }
        }
        dataTask.resume()
    }
}

extension String: Error {}

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









