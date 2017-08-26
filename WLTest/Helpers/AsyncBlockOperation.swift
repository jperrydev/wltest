//
//  AsyncBlockOperation.swift
//  WLTest
//
//  Created by Jordan Perry on 8/26/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

class AsyncBlockOperation: AsyncOperation {
    
    typealias AsyncBlockOperationBlock = (@escaping (Swift.Void) -> Bool, @escaping (Swift.Void) -> Swift.Void) -> Swift.Void
    
    private let block: AsyncBlockOperationBlock
    
    init(block: @escaping AsyncBlockOperationBlock) {
        self.block = block
        super.init()
    }
    
    override func main() {
        guard !self.isCancelled else {
            return
        }
        
        block({ [weak self] in
            guard let strongSelf = self else {
                return true
            }
            
            return strongSelf.isCancelled
            }, { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.status = .Finished
        })
    }
}
