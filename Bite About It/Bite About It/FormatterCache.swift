//
//  FormatterCache.swift
//  Bite About It
//
//  Created by Hector Matos on 8/18/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation

/**
 This is dedicated to jjbernard7!!! Thank you, my ever faithful viewer <3
 */
public class FormatterCache {
    static let shared = FormatterCache()
    public let accessTokenExpirationFormatter: DateFormatter
    
    private init() {
        self.accessTokenExpirationFormatter = DateFormatter()
        self.accessTokenExpirationFormatter.dateFormat = "yyyyMMddHHmmss"
    }
}
