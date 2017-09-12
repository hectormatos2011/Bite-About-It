//
//  BusinessSearch.swift
//  Bite About It
//
//  Created by Hector Matos on 9/12/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import MapKit

public typealias BusinessCallback = (Result<[Business]>) -> Void
public class BusinessSearchOperation: APIOperation<[Business]> {
    override func execute() {
        AuthenticationOperation().start { [weak self] result in
            switch result {
            case .success(let accessToken):
                
            case .failure(let error):
                self?.finish(result: .failure(error))
            }
        }
    }
    
    private func fetchBusinesses(with accessToken: String, completion: @escaping BusinessCallback) {
        let dataTask = URLSession.shared.dataTask(with: Endpoint.businessSearch(CLLocationCoordinate2D(latitude: 37.7749, longitude: 122.4194)).authenticatedRequest(with: accessToken)) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? "Unknown Failure. Maybe no data was returned?"))
                return
            }
            
            // response JSON
            let json = JSON(data: data)
            print(jonnyman9)
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









