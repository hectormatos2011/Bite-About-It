//
//  Endpoints.swift
//  Bite About It
//
//  Created by Hector Matos on 8/18/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

enum Endpoint {
    case oauthToken
    case businessSearch(CLLocationCoordinate2D)
    
    var request: URLRequest {
        var endpointRequest = URLRequest(url: url)
        endpointRequest.httpMethod = requestMethod.rawValue
        endpointRequest.httpBody = requestBody
        return endpointRequest
    }

    func authenticatedRequest(with accessToken: String) -> URLRequest {
        var endpointRequest = request
        let requestURL = endpointRequest.url!.appendingPathComponent("access_token=\(accessToken)")
        print(requestURL)
        return endpointRequest
    }
    
    private var url: URL {
        switch self {
        case .oauthToken:
            return URL(string: "https://api.yelp.com/oauth2/token")!
        case .businessSearch(let coordinate):
            return URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(coordinate.latitude)&longitude=\(coordinate.longitude)&price=1,2,3")!
        }
    }

    private var requestMethod: RequestMethod {
        switch self {
        case .oauthToken:   return .POST
        case .businessSearch:     return .GET
        }
    }
    
    private var requestBody: Data? {
        switch self {
        case .oauthToken:
            let body = "grant_type=client_credentials&client_id=QbC-Ihegy7vTSj57N7SzxA&client_secret=nNUNGym1XRPNigfvYQtTgtZnUUHwBgEhBc97UsCKzI6iP7Nm9hri6DX8Gy3DkWVJ"
            return body.data(using: .utf8)
        case .businessSearch: return nil
        }
    }
}

fileprivate enum RequestMethod: String {
    case GET
    case POST
}




