//
//  FormatterCache.swift
//  Bite About It
//
//  Created by Hector Matos on 8/18/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation

public class FormatterCache {
    static let shared = FormatterCache()
    public let accessTokenExpirationFormatter: DateFormatter
    
    private init() {
        self.accessTokenExpirationFormatter = DateFormatter()
        self.accessTokenExpirationFormatter.dateFormat = "yyyyMMddHHmmss"
    }
}
