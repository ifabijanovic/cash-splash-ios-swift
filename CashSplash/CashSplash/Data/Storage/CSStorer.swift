//
//  CSStorer.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 06/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSStorer<T: Equatable> {
    
    // MARK: - Public methods
    
    internal func getAll() -> Array<T> {
        assertionFailure("method must be implemented in derived class")
    }
    
    internal func count() -> Int {
        assertionFailure("method must be implemented in derived class")
    }
    
    internal func save(item: T) -> Bool {
        assertionFailure("method must be implemented in derived class")
    }
    
    internal func remove(item: T) -> Bool {
        assertionFailure("method must be implemented in derived class")
    }
    
}
