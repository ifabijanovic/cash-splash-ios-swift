//
//  CSSpendingRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSSpendingRepository<T: Equatable>: CSRepository<CSSpending> {
    
    // MARK: - Init
    
    internal override init() {
        super.init()
    }
    
    internal override init(storer: CSStorer<CSSpending>) {
        super.init(storer: storer)
    }
    
    // MARK: - Public methods
    
    public func getAllFromDate(date: NSDate) -> Array<CSSpending> {
        return self.getAll().filter { $0.timestamp.compare(date) == NSComparisonResult.OrderedDescending }
    }
    
    public func get(key: String) -> CSSpending? {
        for model in self.getAll() {
            if model.key == key {
                return model
            }
        }
        return nil
    }
}
