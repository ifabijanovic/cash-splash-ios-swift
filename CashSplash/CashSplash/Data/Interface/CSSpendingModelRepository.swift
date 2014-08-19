//
//  CSSpendingModelRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSSpendingModelRepository {
    internal var storage: Array<CSSpendingModel>
    
    // Init
    
    internal init() {
        self.storage = Array<CSSpendingModel>()
    }
    
    // Public methods
    
    public func getAll() -> Array<CSSpendingModel> {
        return self.storage
    }
    
    public func getAllFromDate(date: NSDate) -> Array<CSSpendingModel> {
        let predicate = NSPredicate(format: "timestamp >= %@", date)
        return self.storage.filter { $0.timestamp.compare(date) == NSComparisonResult.OrderedDescending }
    }
    
    public func get(key: String) -> CSSpendingModel? {
        for model in self.storage {
            if model.key == key {
                return model
            }
        }
        return nil
    }
    
    public func save(model: CSSpendingModel) -> Bool {
        self.storage.append(model)
        return true
    }
    
    public func remove(model: CSSpendingModel) -> Bool {
        var indexToRemove = -1
        for (index, item) in enumerate(self.storage) {
            if item == model {
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
