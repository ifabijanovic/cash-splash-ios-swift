//
//  CSSpendingModelRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSSpendingModelRepository: NSObject {
    var storage: Array<CSSpendingModel>
    
    // Init
    
    init() {
        storage = Array<CSSpendingModel>()
    }
    
    // Public methods
    
    func getAll() -> Array<CSSpendingModel> {
        return self.storage
    }
    
    func getAllFromDate(date: NSDate) -> Array<CSSpendingModel> {
        let predicate = NSPredicate(format: "timestamp >= %@", date)
        return self.storage.filter { $0.timestamp.compare(date) == NSComparisonResult.OrderedDescending }
    }
    
    func get(key: String) -> CSSpendingModel? {
        for model in self.storage {
            if model.key == key {
                return model
            }
        }
        return nil
    }
    
    func save(model: CSSpendingModel) -> Bool {
        self.storage.append(model)
        return true
    }
    
    func remove(model: CSSpendingModel) -> Bool {
        self.storage.removeObject(model)
        return true
    }
}
