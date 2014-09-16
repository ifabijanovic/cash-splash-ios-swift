//
//  CSRepositoryFactory.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSRepositoryFactory {
    
    // Init
    
    internal init() {}
    
    // Public methods
    
    public func createSpendingModelRepository() -> CSSpendingModelRepository<AnyObject> {
        return CSSpendingModelRepository<AnyObject>()
    }
    
    public func createCategoryRepository() -> CSCategoryRepository<AnyObject> {
        return CSCategoryRepository<AnyObject>()
    }
    
    public func createLabelRepository() -> CSLabelRepository<AnyObject> {
        return CSLabelRepository<AnyObject>()
    }
}
