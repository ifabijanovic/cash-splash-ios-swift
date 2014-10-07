//
//  CSDataManager.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 12/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSDataManager {
    
    // MAKR: - Properties
    
    private var factory : CSRepositoryFactory? = nil
    
    public var repositoryFactory : CSRepositoryFactory {
        if (self.factory == nil) {
            self.factory = self.createRepositoryFactory()
        }
        return self.factory!
    }
    
    // MARK: - Singleton
    
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
    
    // MARK: - Private methods
    
    func createRepositoryFactory() -> CSRepositoryFactory {
        let useDropbox = CSSettingsManager.sharedManager().useDropbox
        if (useDropbox) {
            return CSDropboxRepositoryFactory()
        }
        
        return CSRepositoryFactory()
    }
}
