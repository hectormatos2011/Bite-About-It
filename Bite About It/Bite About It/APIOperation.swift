//
//  APIOperation.swift
//  Bite About It
//
//  Created by Hector Matos on 8/30/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation

// MY FIRST SUB, YO
public class MofearOperation: Operation {
    override public var isAsynchronous: Bool { return false }
    override public var isExecuting: Bool { return _executing }
    override public var isFinished: Bool { return _finished }
    
    private var _executing = false {
        willSet { willChangeValue(forKey: "isExecuting") }
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    
    private var _finished = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    
    
    override public func start() {
        guard !isCancelled else {
            finish()
            return
        }
        
        _executing = true
        execute()
    }
    
    func execute() {
        fatalError("The function execute() must be overriden")
    }
    
    func finish() {
        _executing = false
        _finished = true
    }
}
