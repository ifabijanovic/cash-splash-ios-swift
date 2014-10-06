//
//  CSDropboxRepositoryFactory.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 11/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSDropboxRepositoryFactory: CSRepositoryFactory {
    let datastore : DBDatastore?
   
    override init() {
        var error : DBError? = nil
        let account : DBAccount! = DBAccountManager.sharedManager().linkedAccount;
        self.datastore = DBDatastore.openDefaultStoreForAccount(account, error: &error)

        if (error != nil) {
            self.datastore = nil
        } else {
            self.datastore!.sync(nil)
        }
    }
    
    // Public methods
    
    override func createCategoryRepository() -> CSRepository<String> {
        let storer = CSDropboxStringStorer<String>(tableName: "category", datastore: self.datastore)
        return CSRepository<String>(storer: storer)
    }
    
    override func createLabelRepository() -> CSRepository<String> {
        let storer = CSDropboxStringStorer<String>(tableName: "label", datastore: self.datastore)
        return CSRepository<String>(storer: storer)
    }
    
//    override func createSpendingModelRepository() -> CSSpendingModelRepository<AnyObject> {
//        return CSDropboxSpendingModelRepository<AnyObject>(datastore: self.datastore)
//    }
}
