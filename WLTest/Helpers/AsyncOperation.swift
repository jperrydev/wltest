//
//  AsyncOperation.swift
//  WLTest
//
//  Created by Jordan Perry on 8/26/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    enum Status: String {
        case None = "None"
        case Executing = "isExecuting"
        case Cancelled = "isCancelled"
        case Finished = "isFinished"
        
        func willChange<T>(_ with: T) where T: NSObject {
            guard self != .None else {
                return
            }
            
            with.willChangeValue(forKey: rawValue)
        }
        
        func didChange<T>(_ with: T) where T: NSObject {
            guard self != .None else {
                return
            }
            
            with.didChangeValue(forKey: rawValue)
        }
    }
    
    var status: Status = .None {
        willSet {
            status.willChange(self)
            newValue.willChange(self)
        }
        didSet {
            oldValue.didChange(self)
            status.didChange(self)
        }
    }
    
    override var isExecuting: Bool {
        return status == .Executing
    }
    
    override var isCancelled: Bool {
        return status == .Cancelled || super.isCancelled
    }
    
    override var isFinished: Bool {
        return status == .Finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
}
