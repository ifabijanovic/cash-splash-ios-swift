//
//  CSDataManager.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 12/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSDataManager: NSObject {
    var repositoryFactory : CSRepositoryFactory? = nil
    
    // Public methods
    
    func getRepositoryFactory() -> CSRepositoryFactory {
        if (!self.repositoryFactory) {
            self.repositoryFactory = self.createRepositoryFactory()
        }
        return self.repositoryFactory!
    }
    
    // Singleton
    
    struct Singleton {
        static var token : dispatch_once_t = 0
        static var instance : CSDataManager?
    }
    
    class func sharedManager() -> CSDataManager {
    dispatch_once(&Singleton.token) {
        Singleton.instance = CSDataManager()
        }
        return Singleton.instance!
    }
    
    // Private methods
    
    func createRepositoryFactory() -> CSRepositoryFactory {
        let useDropbox = CSSettingsManager.sharedManager().useDropbox
        if (useDropbox) {
            return CSDropboxRepositoryFactory()
        }
        
        return CSRepositoryFactory()
    }
}
