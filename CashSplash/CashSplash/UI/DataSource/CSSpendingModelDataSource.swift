//
//  CSSpendingModelDataSource.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/08/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSSpendingModelDataSource: CSDataSourceBase {
    
    // Properties
    
    private var repository : CSSpendingModelRepository<AnyObject>
    private var storage : Array<CSSpendingModel>
    
    // Init
    
    public override init() {
        let factory = CSDataManager.sharedManager().repositoryFactory
        self.repository = factory.createSpendingModelRepository()
        self.storage = repository.getAll()
        
        super.init()
    }
    
    public override func reload() {
        let factory = CSDataManager.sharedManager().repositoryFactory
        self.repository = factory.createSpendingModelRepository()
        self.storage = repository.getAll()
    }
    
    // Public methods
    
    public func items() -> Array<CSSpendingModel> {
        return self.storage
    }
    
    public func count() -> Int {
        return self.storage.count
    }
    
    public func save(item: CSSpendingModel) -> Bool {
        var itemExists = false
        for (index, element) in enumerate(self.storage) {
            if element == item {
                itemExists = true
                break
            }
        }
        
        if !itemExists {
            if self.repository.save(item) {
                self.storage.append(item)
                return true
            }
        }
        
        return false
    }
    
    public func remove(item: CSSpendingModel) -> Bool {
        var indexToRemove = -1
        for (index, element) in enumerate(self.storage) {
            if element == item {
                indexToRemove = index
                break
            }
        }
        
        if (indexToRemove > -1) {
            self.storage.removeAtIndex(indexToRemove)
            return true
        }
        
        return false
    }
    
    public func refresh() {
        let daysToDisplay = CSSettingsManager.sharedManager().dataDisplaysDays
        let secondsToDisplay = -daysToDisplay * 24 * 60 * 60
        let loadDate = NSDate(timeIntervalSinceNow: Double(secondsToDisplay))
        
        self.storage = self.repository.getAllFromDate(loadDate)
    }
    
}
