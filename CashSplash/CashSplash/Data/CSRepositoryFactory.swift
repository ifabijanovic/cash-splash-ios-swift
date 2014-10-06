//
//  CSRepositoryFactory.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSRepositoryFactory {
    
    // MARK: - Init
    
    internal init() {}
    
    // MARK: - Public methods
    
    public func createSpendingModelRepository() -> CSSpendingRepository<CSSpending> {
        return CSSpendingRepository<CSSpending>()
    }
    
    public func createCategoryRepository() -> CSRepository<String> {
        return CSRepository<String>()
    }
    
    public func createLabelRepository() -> CSRepository<String> {
        return CSRepository<String>()
    }
}
