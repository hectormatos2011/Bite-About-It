//
//  Category.swift
//  Bite About It
//
//  Created by Hector Matos on 10/11/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol Templateable {}

// This struct is dedicated to CratyDeanoUK! Thanks for the sub and I'm sorry for the booty shake 😜
public enum Category: Templateable {
    case breakfast
    case lunch
    case dinner
    case dessert
    case coffee
    case alcohol
}
