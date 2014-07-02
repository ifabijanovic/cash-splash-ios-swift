//
//  CSCategoryRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSCategoryRepository: NSObject {
    var storage: Array<String>
    
    // Init
    
    init() {
        storage = Array<String>()
    }
    
    // Public methods
    
    func getAll() -> Array<String> {
        return self.storage
    }
    
    func save(category: String) -> Bool {
        self.storage.append(category)
        return true
    }
    
    func remove(category: String) -> Bool {
        self.storage.removeObject(category)
        return true
    }
}
