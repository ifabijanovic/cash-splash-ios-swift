//
//  CSDropboxLabelRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 11/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSDropboxLabelRepository: CSLabelRepository {
    let tableName = "label"
    let datastore : DBDatastore?
    let table : DBTable?
    
    // Init
    
    internal init(datastore: DBDatastore?) {
        self.datastore = datastore
        if (datastore != nil) {
            self.table = self.datastore!.getTable(self.tableName)
        }
    }
    
    // Public methods
    
    override func getAll() -> Array<String> {
        if (self.table != nil) {
            CSDropboxManager.syncDatastore(self.datastore)
            var error : DBError? = nil
            let data : NSArray! = self.table!.query(nil, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Label getAll error: %@", error!)
                return Array<String>()
            }
            
            let dataArray = data as Array<DBRecord>
            var items = Array<String>()
            for item in dataArray {
                items.append(item["name"] as String)
            }
            
            return items
        }
        
        return Array<String>()
    }
    
    override func save(label: String) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            let dictionary = ["name": label] as NSDictionary
            
            self.table!.insert(dictionary)
            self.datastore!.sync(&error)
            
            if (error != nil) {
                NSLog("[Dropbox] Label save error: %@", error!);
                return false
            }
            
            return true
        }
        return false
    }
    
    override func remove(label: String) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            
            let dictionary = ["name": label] as NSDictionary
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Label remove error: %@", error!);
                return false
            }
            
            error = nil
            let data = records as Array<DBRecord>
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record != nil) {
                record!.deleteRecord()
                self.datastore!.sync(&error)
                
                if (error != nil) {
                    NSLog("[Dropbox] Label remove error: %@", error!);
                    return false
                }
            }
            
            return true
        }
        return false
    }
}
