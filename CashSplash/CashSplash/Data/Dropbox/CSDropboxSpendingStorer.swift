//
//  CSDropboxSpendingStorer.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 06/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSDropboxSpendingStorer<T: Equatable>: CSSpendingStorer<CSSpending> {
   
    // MARK: - Properties
    
    private let tableName = "spending_model"
    private let datastore : DBDatastore?
    private let table : DBTable?
    
    // MARK: - Init
    
    internal init(datastore: DBDatastore?) {
        self.datastore = datastore
        if (datastore != nil) {
            self.table = self.datastore!.getTable(self.tableName)
        }
    }

    // MARK: - Public methods
    
    internal override func getAll() -> Array<CSSpending> {
        if (self.table != nil) {
            CSDropboxManager.syncDatastore(self.datastore)
            var error : DBError? = nil
            let data : NSArray! = self.table!.query(nil, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending getAll error: %@", error!)
                return Array<CSSpending>()
            }
            
            let dataArray = data as Array<DBRecord>
            var items = Array<CSSpending>()
            for item in dataArray {
                items.append(self.spendingFromDBRecord(item))
            }
            
            return items
        }
        
        return Array<CSSpending>()
    }
    
    internal override func getAllFromDate(date: NSDate) -> Array<CSSpending> {
        var items = self.getAll()
        
        sort(&items, {
            let result = $0.timestamp.compare($1.timestamp)
            return result == NSComparisonResult.OrderedDescending
        })
        
        return items
    }
    
    internal override func get(key: String) -> CSSpending? {
        if (self.table != nil) {
            CSDropboxManager.syncDatastore(self.datastore)
            var error : DBError? = nil
            
            let dictionary = ["key": key] as NSDictionary
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending get error: %@", error!)
                return nil
            }
            
            error = nil
            let data = records as Array<DBRecord>
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record != nil) {
                return self.spendingFromDBRecord(record!)
            }
        }
        
        return nil
    }
    
    internal override func save(item: CSSpending) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            
            let item = self.dictionaryFromSpending(item)
            
            self.table!.insert(item)
            self.datastore!.sync(&error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending save error: %@", error!);
                return false
            }
            
            return true
        }
        
        return false
    }
    
    internal override func remove(item: CSSpending) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            
            let dictionary = ["key": item.key] as NSDictionary
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending remove error: %@", error!);
                return false
            }
            
            error = nil
            let data = records as Array<DBRecord>
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record != nil) {
                record!.deleteRecord()
                self.datastore!.sync(&error)
                
                if (error != nil) {
                    NSLog("[Dropbox] Spending remove error: %@", error!);
                    return false
                }
            }
            
            return true
        }
        
        return false
    }
    
    // MARK: - Private methods
    
    private func spendingFromDBRecord(dbRecord: DBRecord) -> CSSpending {
        var spending = CSSpending(key: dbRecord["key"] as String)
        spending.amount = dbRecord["amount"] as Float
        spending.category = dbRecord["category"] as String?
        spending.label = dbRecord["label"] as String?
        spending.timestamp = dbRecord["timestamp"] as NSDate
        spending.note = dbRecord["note"] as String?
        
        return spending
    }
    
    private func dictionaryFromSpending(spending : CSSpending) -> NSDictionary {
        var dictionary = NSDictionary()
        dictionary.setValue(spending.key, forKey: "key")
        dictionary.setValue(NSNumber(float: spending.amount), forKey: "amount")
        dictionary.setValue(spending.category, forKey: "category")
        dictionary.setValue(spending.label, forKey: "label")
        dictionary.setValue(spending.timestamp, forKey: "timestamp")
        dictionary.setValue(spending.note, forKey: "note")
        
        return dictionary
    }
    
}
