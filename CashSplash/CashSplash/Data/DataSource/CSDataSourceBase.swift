//
//  CSDataSourceBase.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/08/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

let kNotificationStorageChanged = "storage-changed"

internal class CSDataSourceBase {
   
    // Init
    
    internal init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload", name: kNotificationStorageChanged, object: CSDataManager.sharedManager())
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationStorageChanged, object: CSDataManager.sharedManager())
    }
    
    internal func reload() {
        
    }
}
