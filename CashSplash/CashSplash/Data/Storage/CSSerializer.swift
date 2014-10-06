//
//  CSSerializer.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 06/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSSerializer<T: Equatable> {
    
    // MARK: - Public methods
    
    internal func serialize(item: T) -> NSDictionary {
        assertionFailure("method must be implemented in derived class")
    }
    
    internal func deserialize(block: NSDictionary) -> T {
        assertionFailure("method must be implemented in derived class")
    }
    
}
