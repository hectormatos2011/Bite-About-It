//
//  PaymentMethod.swift
//  Bite About It
//
//  Created by Hector Matos on 10/12/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation

// This is dedicated to drewklayman! THANKS FOR THE SUB, YO!
public struct TransactionMethod: OptionSet, AutoEquatable {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static let none =           TransactionMethod(rawValue: 0)
    public static let pickup =         TransactionMethod(rawValue: 1)
    public static let delivery =       TransactionMethod(rawValue: 1 << 1)
    public static let reservation =    TransactionMethod(rawValue: 1 << 2)
    
    public static func methodFrom(string: String) -> TransactionMethod {
        switch string {
        case "pickup":
            return .pickup
        case "delivery":
            return .delivery
        case "restaurant_reservation":
            return .reservation
        default:
            return .none
        }
    }
}










