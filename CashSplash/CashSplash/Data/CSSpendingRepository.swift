//
//  CSSpendingRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSSpendingRepository<T: Equatable>: CSRepository<CSSpending> {
    
    // MARK: - Properties
    
    internal let spendingStorer: CSSpendingStorer<CSSpending>?
    
    // MARK: - Init
    
    internal override init() {
        self.spendingStorer = nil
        super.init()
    }
    
    internal init(storer: CSSpendingStorer<CSSpending>) {
        self.spendingStorer = storer
        super.init(storer: storer)
    }
    
    // MARK: - Public methods
    
    public func getAllFromDate(date: NSDate) -> Array<CSSpending> {
        if let s = self.spendingStorer {
            return s.getAllFromDate(date)
        }
        
        return self.getAll().filter { $0.timestamp.compare(date) == NSComparisonResult.OrderedDescending }
    }
    
    public func get(key: String) -> CSSpending? {
        if let s = self.spendingStorer {
            return s.get(key)
        }
        
        for model in self.getAll() {
            if model.key == key {
                return model
            }
        }
        return nil
    }
}
