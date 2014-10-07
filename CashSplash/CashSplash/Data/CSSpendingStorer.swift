//
//  CSSpendingStorer.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSSpendingStorer<T: Equatable>: CSStorer<CSSpending> {
   
    // MARK: - Public methods
    
    internal func getAllFromDate(date: NSDate) -> Array<T> {
        assertionFailure("method must be implemented in derived class")
    }
    
    internal func get(key: String) -> T? {
        assertionFailure("method must be implemented in derived class")
    }
    
}
