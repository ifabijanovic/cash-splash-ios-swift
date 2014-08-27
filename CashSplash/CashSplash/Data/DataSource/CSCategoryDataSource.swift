//
//  CSCategoryDataSource.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/08/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSCategoryDataSource: CSDataSourceBase, CSTablePickerDataSource {
    
    // Properties
    
    private var repository : CSCategoryRepository
    private var storage : Array<String>
    
    // Init
    
    public override init() {
        let factory = CSDataManager.sharedManager().repositoryFactory
        self.repository = factory.createCategoryRepository()
        self.storage = repository.getAll()
        
        super.init()
    }
    
    override func reload() {
        let factory = CSDataManager.sharedManager().repositoryFactory
        self.repository = factory.createCategoryRepository()
        self.storage = repository.getAll()
    }
    
    // CSTablePickerDataSource
    typealias ItemType = String
    
    func items() -> Array<String> {
        return self.storage
    }
    
    func count() -> Int {
        return self.storage.count
    }
    
    func save(item: String) -> Bool {
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
    
    func remove(item: String) -> Bool {
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
    
}
