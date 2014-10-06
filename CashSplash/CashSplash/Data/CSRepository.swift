//
//  CSRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/08/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSRepository<T: Equatable> {
    
    // MARK: - Properties
    
    internal var storage: Array<T>
    internal let storer: CSStorer<T>?
    internal var isLoaded: Bool
    
    // MARK: - Init
    
    internal init() {
        self.storage = Array<T>()
        self.storer = nil
        self.isLoaded = true
    }
    
    internal init(storer: CSStorer<T>) {
        self.storage = Array<T>()
        self.storer = storer
        self.isLoaded = false
    }
    
    // MARK: - Public methods
    
    public func getAll() -> Array<T> {
        if (self.isLoaded) {
            return self.storage
        }
        
        self.storage = self.storer!.getAll()
        self.isLoaded = true
        
        return self.storage
    }
    
    public func count() -> Int {
        return self.storage.count
    }
    
    public func save(item: T) -> Bool {
        var result = true
        if let s = self.storer {
            result = s.save(item)
        }

        if (result) {
            if let existing = self.findItem(item) {
                self.storage[existing.index] = item
            } else {
                self.storage.append(item)
            }
        }
        
        return result
    }
    
    public func remove(item: T) -> Bool {
        var result = true
        if let s = self.storer {
            result = s.remove(item)
        }
        
        if (result) {
            if let existing = self.findItem(item) {
                self.storage.removeAtIndex(existing.index)
            }
        }

        return result
    }
    
    public func refresh() {
        if (self.storer != nil) {
            self.storage.removeAll(keepCapacity: false)
            self.isLoaded = false
        }
    }
    
    // MARK: - Private methods
    
    internal func findItem(item: T) -> (index: Int, element: T)? {
        for (index, element) in enumerate(self.storage) {
            if (element == item) {
                return (index, element)
            }
        }
        return nil
    }
    
}
