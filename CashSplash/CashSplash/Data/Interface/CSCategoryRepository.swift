//
//  CSCategoryRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSCategoryRepository {
    internal var storage: Array<String>
    
    // Init
    
    internal init() {
        self.storage = Array<String>()
    }
    
    // Public methods
    
    public func getAll() -> Array<String> {
        return self.storage
    }
    
    public func save(category: String) -> Bool {
        self.storage.append(category)
        return true
    }
    
    public func remove(category: String) -> Bool {
        var indexToRemove = -1
        for (index, item) in enumerate(self.storage) {
            if item == category {
                indexToRemove = index
                break
            }
        }
        
        if (indexToRemove > -1) {
            self.storage.removeAtIndex(indexToRemove)
        }
        
        return true
    }
}
