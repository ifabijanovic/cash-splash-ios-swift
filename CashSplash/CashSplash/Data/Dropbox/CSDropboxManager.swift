//
//  CSDropboxManager.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 11/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSDropboxManager: NSObject {
    
    // Public methods
    
    class func syncDatastore(datastore: DBDatastore?) {
        if (datastore && datastore!.status == Int(DBDatastoreIncoming.value)) {
            datastore!.sync(nil)
        }
    }
}
