//
//  Business.swift
//  Bite About It
//
//  Created by Hector Matos on 9/12/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

/**
 This is dedicated to tandjaoul! Thanks FOR THE SUB!!!!! HYPE
 */
public struct Business {
    let id: String
    let isClosed: Bool
    let categories: [Category]
    let rating: Float
    let phoneNumber: String
    let phoneNumberDisplay: String
    let imageURL: URL?
    let pageURL: URL?
    let coordinate: CLLocationCoordinate2D
    let transactionMethod: TransactionMethod
    
    init(json: JSON) {
        id = json["id"].stringValue
        isClosed = json["is_closed"].boolValue
        categories = json["categories"].arrayValue.flatMap(Category.init(json:))
        rating = json["rating"].floatValue
        phoneNumber = json["phone"].stringValue
        phoneNumberDisplay = json["display_phone"].stringValue
        imageURL = URL(string: json["image_url"].stringValue)
        pageURL = URL(string: json["url"].stringValue)
        coordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(json["latitude"].floatValue),
            longitude: CLLocationDegrees(json["longitude"].floatValue)
        )

        var newMethod: TransactionMethod = .none
        if let methodStrings = json["transactions"].arrayObject as? [String] {
            for transactionMethodString in methodStrings {
                newMethod.insert(.methodFrom(string: transactionMethodString))
            }
        }
        transactionMethod = newMethod
    }
}
