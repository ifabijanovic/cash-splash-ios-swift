//
//  CSLabelDataSource.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/08/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSLabelDataSource: CSDataSourceBase, CSTablePickerDataSource {
    
    // Properties
    
    private var repository : CSLabelRepository
    private var storage : Array<String>
    
    // Init
    
    public override init() {
        let factory = CSDataManager.sharedManager().repositoryFactory
        self.repository = factory.createLabelRepository()
        self.storage = repository.getAll()
        
        super.init()
    }
    
    public override func reload() {
        let factory = CSDataManager.sharedManager().repositoryFactory
        self.repository = factory.createLabelRepository()
        self.storage = repository.getAll()
    }

    // CSTablePickerDataSource
    typealias ItemType = String
    
    public func items() -> Array<String> {
        return self.storage
    }
    
    public func count() -> Int {
        return self.storage.count
    }
    
    public func save(item: String) -> Bool {
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
    
    public func remove(item: String) -> Bool {
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
        self.storage = self.repository.getAll()
    }

}
