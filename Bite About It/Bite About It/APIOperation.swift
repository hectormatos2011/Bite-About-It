//
//  APIOperation.swift
//  Bite About It
//
//  Created by Hector Matos on 8/30/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import Foundation

// MY FIRST SUB, YO
public class MofearOperation<T>: Operation {
    override public var isAsynchronous: Bool { return false }
    override public var isExecuting: Bool { return _executing }
    override public var isFinished: Bool { return _finished }
    public var result: Result<T>!
    
    private var _executing = false {
        willSet { willChangeValue(forKey: "isExecuting") }
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    
    private var _finished = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    
    public func start(completion: @escaping (Result<T>) -> Void) {
        self.completionBlock = { [weak self] in
            guard let `self` = self else {
                completion(.failure("Operation doesn't exist"))
                return
            }
            completion(self.result)
        }
        start()
    }
    
    override public func start() {
        guard !isCancelled else {
            finish(result: .failure("Operation was cancelled"))
            return
        }
        
        _executing = true
        execute()
    }
    
    func execute() {
        fatalError("The function execute() must be overriden")
    }
    
    func finish(result: Result<T>) {
        self.result = result
        _executing = false
        _finished = true
    }
}

extension String: Error {}
