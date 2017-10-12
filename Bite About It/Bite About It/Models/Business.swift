//
//  Business.swift
//  Bite About It
//
//  Created by Hector Matos on 9/12/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 This is dedicated to tandjaoul! Thanks FOR THE SUB!!!!! HYPE
 */
public struct Business {
    let id: String
    let isClosed: Bool
    let categories: [Category]
    
    init(json: JSON) {
        /*
         {
         "id" : "pink-onion-san-francisco",
         "is_closed" : false,
         "review_count" : 78,
         "categories" : [
         {
         "alias" : "pizza",
         "title" : "Pizza"
         },
         {
         "alias" : "italian",
         "title" : "Italian"
         },
         {
         "alias" : "gastropubs",
         "title" : "Gastropubs"
         }
         ],
         "rating" : 4.5,
         "phone" : "+14155292635",
         "image_url" : "https:\/\/s3-media3.fl.yelpcdn.com\/bphoto\/8GtQUJi_GHlrng88Mv9TOQ\/o.jpg",
         "url" : "https:\/\/www.yelp.com\/biz\/pink-onion-san-francisco?adjust_creative=QbC-Ihegy7vTSj57N7SzxA&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=QbC-Ihegy7vTSj57N7SzxA",
         "display_phone" : "(415) 529-2635",
         "price" : "$$",
         "location" : {
         "display_address" : [
         "64 14th St",
         "San Francisco, CA 94103"
         ],
         "city" : "San Francisco",
         "address1" : "64 14th St",
         "zip_code" : "94103",
         "country" : "US",
         "address3" : "",
         "state" : "CA",
         "address2" : null
         },
         "coordinates" : {
         "longitude" : -122.41482000000001,
         "latitude" : 37.768709999999999
         },
         "transactions" : [
         "pickup",
         "restaurant_reservation"
         ],
         "distance" : 789.16062948599995,
         "name" : "Pink Onion"
         }
         */
    }
}
