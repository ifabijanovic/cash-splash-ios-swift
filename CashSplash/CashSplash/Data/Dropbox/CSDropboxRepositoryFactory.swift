//
//  CSDropboxRepositoryFactory.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 11/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSDropboxRepositoryFactory: CSRepositoryFactory {
    let datastore : DBDatastore?
   
    init() {
        var error : DBError? = nil
        let account : DBAccount! = DBAccountManager.sharedManager().linkedAccount;
        self.datastore = DBDatastore.openDefaultStoreForAccount(account, error: &error)

        if (error) {
            self.datastore = nil
        } else {
            self.datastore!.sync(nil)
        }
    }
    
    // Public methods
    
    override func createCategoryRepository() -> CSCategoryRepository {
        return CSDropboxCategoryRepository(datastore: self.datastore)
    }
    
    override func createLabelRepository() -> CSLabelRepository {
        return CSDropboxLabelRepository(datastore: self.datastore)
    }
    
    override func createSpendingModelRepository() -> CSSpendingModelRepository {
        return CSDropboxSpendingModelRepository(datastore: self.datastore)
    }
}
