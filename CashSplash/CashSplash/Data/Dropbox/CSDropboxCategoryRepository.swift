//
//  CSDropboxCategoryRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSDropboxCategoryRepository: CSCategoryRepository {
    let tableName = "category"
    let datastore : DBDatastore?
    let table : DBTable?
    
    // Init
    
    init(datastore: DBDatastore?) {
        self.datastore = datastore
        if (datastore) {
            self.table = self.datastore!.getTable(self.tableName)
        }
    }
    
    // Public methods
    
    override func getAll() -> Array<String> {
        if (self.table) {
            // Sync here
            var error : DBError? = nil
            let data : NSArray! = self.table!.query(nil, error: &error)
            
            if (error) {
                NSLog("[Dropbox] Category getAll error: %@", error!)
                return Array<String>()
            }
            
            let dataArray = Array<DBRecord>.bridgeFromObjectiveC(data)
            var items = Array<String>()
            for item in dataArray {
                items.append(item["name"] as String)
            }
            
            return items
        }
        
        return Array<String>()
    }
    
    override func save(category: String) -> Bool {
        if (self.table) {
            var error : DBError? = nil
            let item = ["name": category]
            let dictionary = item.bridgeToObjectiveC()
            
            self.table!.insert(dictionary)
            self.datastore!.sync(&error)
            
            if (error) {
                NSLog("[Dropbox] Category save error: %@", error!);
                return false
            }
            
            return true
        }
        return false
    }
    
    override func remove(category: String) -> Bool {
        if (self.table) {
            var error : DBError? = nil
            
            let item = ["name": category]
            let dictionary = item.bridgeToObjectiveC()
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error) {
                NSLog("[Dropbox] Category remove error: %@", error!);
                return false
            }
            
            error = nil
            let data = Array<DBRecord>.bridgeFromObjectiveC(records)
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record) {
                record!.deleteRecord()
                self.datastore!.sync(&error)
                
                if (error) {
                    NSLog("[Dropbox] Category remove error: %@", error!);
                    return false
                }
            }
            
            return true
        }
        return false
    }
}
