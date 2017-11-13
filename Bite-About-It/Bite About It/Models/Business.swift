//
//  Business.swift
//  Bite About It
//
//  Created by Hector Matos on 9/12/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

/**
 This is dedicated to tandjaoul! Thanks FOR THE SUB!!!!! HYPE
 */
public struct Business: AutoEquatable, Comparable, CustomStringConvertible {
    let id: String
    let name: String
    let isClosed: Bool
    let rating: Float
    let phoneNumber: String
    let phoneNumberDisplay: String
    let imageURL: URL?
    let pageURL: URL?
    let categories: [BusinessCategory]
    let coordinate: CLLocationCoordinate2D
    let transactionMethod: TransactionMethod
    
    public var description: String {
        return name
    }
    
    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        isClosed = json["is_closed"].boolValue
        rating = json["rating"].floatValue
        phoneNumber = json["phone"].stringValue
        phoneNumberDisplay = json["display_phone"].stringValue
        imageURL = URL(string: json["image_url"].stringValue)
        pageURL = URL(string: json["url"].stringValue)
        categories = json["categories"].arrayValue.flatMap {
            let alias = $0["alias"].stringValue
            let title = $0["title"].stringValue
            return BusinessCategory(alias: alias, title: title)
        }
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
    
    public static func <(lhs: Business, rhs: Business) -> Bool {
        return lhs.rating < rhs.rating
    }
}

public struct BusinessCategory: AutoEquatable {
    public let alias: String
    public let title: String
}

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
