//
//  CSLabelRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSLabelRepository {
    internal var storage: Array<String>
    
    // Init
    
    internal init() {
        self.storage = Array<String>()
    }
    
    // Public methods
    
    public func getAll() -> Array<String> {
        return self.storage
    }
    
    public func save(label: String) -> Bool {
        self.storage.append(label)
        return true
    }
    
    public func remove(label: String) -> Bool {
        var indexToRemove = -1
        for (index, item) in enumerate(self.storage) {
            if item == label {
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
