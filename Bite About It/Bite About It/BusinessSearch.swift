//
//  BusinessSearch.swift
//  Bite About It
//
//  Created by Hector Matos on 9/12/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import MapKit
import SwiftyJSON

public typealias BusinessCallback = (Result<[Business]>) -> Void

// This class is dedicated to the very lovely Ceaira! YOU'RE AMAZING AND THE BEST PERSON EVER GAH
public class BusinessSearchOperation: APIOperation<[Business]> {
    override func execute() {
        AuthenticationOperation().start { authResult in
            switch authResult {
            case .success(let accessToken):
                self.fetchBusinesses(with: accessToken, completion: self.finish)
            case .failure(let error):
                self.finish(result: .failure(error))
            }
        }
    }
    
    private func fetchBusinesses(with accessToken: String, completion: @escaping BusinessCallback) {
        let dataTask = URLSession.shared.dataTask(with: Endpoint.businessSearch(CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)).authenticatedRequest(with: accessToken)) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? "Unknown Failure. Maybe no data was returned?"))
                return
            }
            
            // response JSON
            let json = JSON(data: data)
            if let errorDescription = json["error"]["description"].string {
                completion(.failure(errorDescription))
            } else {
                completion(.success(json["businesses"].arrayValue.flatMap(Business.init(json:))))
            }
        }
        dataTask.resume()
    }
}

