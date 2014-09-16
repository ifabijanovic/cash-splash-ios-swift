//
//  CSRepositoryBase.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/08/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSRepositoryBase<T: Equatable> {
    
    // Properties
    
    internal var storage: Array<T>
    
    // Init
    
    internal init() {
        self.storage = Array<T>()
    }
    
    // Public methods
    
    public func getAll() -> Array<T> {
        return self.storage
    }
    
    public func count() -> Int {
        return self.storage.count
    }
    
    public func save(item: T) -> Bool {
        if let existing = self.findItem(item) {
            self.storage[existing.index] = item
        } else {
            self.storage.append(item)
        }
        return true
    }
    
    public func remove(item: T) -> Bool {
        if let existing = self.findItem(item) {
            self.storage.removeAtIndex(existing.index)
        }
        return true
    }
    
    public func refresh() {
        // Implement in derived classes
    }
    
    // Private methods
    
    internal func findItem(item: T) -> (index: Int, element: T)? {
        for (index, element) in enumerate(self.storage) {
            if (element == item) {
                return (index, element)
            }
        }
        return nil
    }
    
}
