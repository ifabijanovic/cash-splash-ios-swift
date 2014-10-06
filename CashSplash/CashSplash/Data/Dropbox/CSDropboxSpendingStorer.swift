//
//  CSDropboxSpendingStorer.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 06/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSDropboxSpendingStorer<T: Equatable>: CSStorer<CSSpending> {
   
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
                items.append(self.modelFromDBRecord(item))
            }
            
            return items
        }
        
        return Array<CSSpending>()
    }
    
    internal override func save(item: CSSpending) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            
            let item = self.dictionaryFromModel(item)
            
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
    
    private func modelFromDBRecord(dbRecord: DBRecord) -> CSSpending {
        var model = CSSpending(key: dbRecord["key"] as String)
        model.amount = dbRecord["amount"] as Float
        model.category = dbRecord["category"] as String?
        model.label = dbRecord["label"] as String?
        model.timestamp = dbRecord["timestamp"] as NSDate
        model.note = dbRecord["note"] as String?
        
        return model
    }
    
    private func dictionaryFromModel(model : CSSpending) -> NSDictionary {
        var dictionary = NSDictionary()
        dictionary.setValue(model.key, forKey: "key")
        dictionary.setValue(NSNumber(float: model.amount), forKey: "amount")
        dictionary.setValue(model.category, forKey: "category")
        dictionary.setValue(model.label, forKey: "label")
        dictionary.setValue(model.timestamp, forKey: "timestamp")
        dictionary.setValue(model.note, forKey: "note")
        
        return dictionary
    }
    
}
