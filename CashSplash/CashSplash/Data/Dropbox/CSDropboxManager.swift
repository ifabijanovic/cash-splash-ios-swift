//
//  CSDropboxManager.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 11/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSDropboxManager: NSObject {
    
    // MARK: - Public methods
    
    internal class func syncDatastore(datastore: DBDatastore?) {
        if let ds = datastore {
            if ds.status == UInt(DBDatastoreIncoming.value) {
                ds.sync(nil)
            }
        }
    }
}
