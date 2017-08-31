//
//  Endpoints.swift
//  Bite About It
//
//  Created by Hector Matos on 8/18/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Endpoint {
    case oauthToken
    case location
    
    var request: URLRequest {
        var endpointRequest = URLRequest(url: url)
        endpointRequest.httpMethod = requestMethod.rawValue
        endpointRequest.httpBody = requestBody
        return endpointRequest
    }
    
    private var url: URL {
        switch self {
        case .oauthToken:
            return URL(string: "https://api.yelp.com/oauth2/token")!
        case .location:
            return URL(string: "")!
        }
    }

    private var requestMethod: RequestMethod {
        switch self {
        case .oauthToken:   return .POST
        case .location:     return .GET
        }
    }
    
    private var requestBody: Data? {
        switch self {
        case .oauthToken:
            let body = "grant_type=client_credentials&client_id=QbC-Ihegy7vTSj57N7SzxA&client_secret=nNUNGym1XRPNigfvYQtTgtZnUUHwBgEhBc97UsCKzI6iP7Nm9hri6DX8Gy3DkWVJ"
            return body.data(using: .utf8)
        case .location: return nil
        }
    }
}

fileprivate enum RequestMethod: String {
    case GET
    case POST
}




