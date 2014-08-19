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
    
    public func createSpendingModelRepository() -> CSSpendingModelRepository {
        return CSSpendingModelRepository()
    }
    
    public func createCategoryRepository() -> CSCategoryRepository {
        return CSCategoryRepository()
    }
    
    public func createLabelRepository() -> CSLabelRepository {
        return CSLabelRepository()
    }
}
