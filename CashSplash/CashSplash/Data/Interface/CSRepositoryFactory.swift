//
//  CSRepositoryFactory.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSRepositoryFactory: NSObject {
    
    // Public methods
    
    func createSpendingModelRepository() -> CSSpendingModelRepository {
        return CSSpendingModelRepository()
    }
    
    func createCategoryRepository() -> CSCategoryRepository {
        return CSCategoryRepository()
    }
    
    func createLabelRepository() -> CSLabelRepository {
        return CSLabelRepository()
    }
}
