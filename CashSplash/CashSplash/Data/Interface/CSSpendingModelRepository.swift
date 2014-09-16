//
//  CSSpendingModelRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSSpendingModelRepository<T>: CSRepositoryBase<CSSpendingModel> {
    
    // Public methods
    
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
}
