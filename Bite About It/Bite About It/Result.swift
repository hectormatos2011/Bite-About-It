//
//  Result.swift
//  Bite About It
//
//  Created by Hector Matos on 8/18/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error?)
}
