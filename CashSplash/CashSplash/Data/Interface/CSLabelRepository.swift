//
//  CSLabelRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSLabelRepository: NSObject {
    var storage: Array<String>
    
    // Init
    
    init() {
        storage = Array<String>()
    }
    
    // Public methods
    
    func getAll() -> Array<String> {
        return self.storage
    }
    
    func save(label: String) -> Bool {
        self.storage.append(label)
        return true
    }
    
    func remove(label: String) -> Bool {
        self.storage.removeObject(label)
        return true
    }
}
