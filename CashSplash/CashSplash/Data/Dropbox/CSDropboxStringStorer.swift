//
//  CSDropboxStringStorer.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 06/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSDropboxStringStorer<T: Equatable>: CSStorer<String> {
    
    // MARK: - Properties
    
    private let tableName : String
    private let datastore : DBDatastore?
    private let table : DBTable?
    
    // MARK: - Init
    
    internal init(tableName: String, datastore: DBDatastore?) {
        self.tableName = tableName
        self.datastore = datastore
        if (datastore != nil) {
            self.table = self.datastore!.getTable(self.tableName)
        }
    }
    
    // MARK: - Public methods
    
    internal override func getAll() -> Array<String> {
        if (self.table != nil) {
            CSDropboxManager.syncDatastore(self.datastore)
            var error : DBError? = nil
            let data : NSArray! = self.table!.query(nil, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] %@ getAll error: %@", self.tableName, error!)
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
    
    internal override func save(item: String) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            let dictionary = ["name": item] as NSDictionary
            
            self.table!.insert(dictionary)
            self.datastore!.sync(&error)
            
            if (error != nil) {
                NSLog("[Dropbox] %@ save error: %@", self.tableName, error!);
                return false
            }
            
            return true
        }
        return false
    }
    
    internal override func remove(item: String) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            
            let dictionary = ["name": item] as NSDictionary
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] %@ remove error: %@", self.tableName, error!);
                return false
            }
            
            error = nil
            let data = records as Array<DBRecord>
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record != nil) {
                record!.deleteRecord()
                self.datastore!.sync(&error)
                
                if (error != nil) {
                    NSLog("[Dropbox] %@ remove error: %@", self.tableName, error!);
                    return false
                }
            }
            
            return true
        }
        return false
    }
    
}
