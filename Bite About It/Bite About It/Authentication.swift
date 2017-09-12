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

/**
 This class is dedicated to the honorable Kwelly8. Thanks for the sub!
 */
public class AuthenticationOperation: APIOperation<String> {
    private let keychain = Keychain(service: "com.krakendev.authentication")
    
    private enum KeychainKeys: String {
        case yelpAccessToken
    }
    
    override func execute() {
        guard let accessToken = AccessToken(keychainData: keychain[data: KeychainKeys.yelpAccessToken.rawValue]), accessToken.isValid else {
            fetchAccessToken(completion: finish)
            return
        }
        finish(result: .success(accessToken.token))
    }
    
    private func fetchAccessToken(completion: @escaping AuthenticationCallback) {
        let dataTask = URLSession.shared.dataTask(with: Endpoint.oauthToken.request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? "Unknown Failure. Maybe no data was returned?"))
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









