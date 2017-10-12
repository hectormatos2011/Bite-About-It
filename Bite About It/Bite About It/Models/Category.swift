//
//  Category.swift
//  Bite About It
//
//  Created by Hector Matos on 10/11/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Category {
    let alias: String
    let title: String
    
    init(json: JSON) {
        alias = json["alias"].stringValue
        title = json["title"].stringValue
    }
}
