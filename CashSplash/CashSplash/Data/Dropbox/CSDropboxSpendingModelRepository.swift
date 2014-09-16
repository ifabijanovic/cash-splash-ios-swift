//
//  CSDropboxSpendingModelRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 11/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSDropboxSpendingModelRepository<T>: CSSpendingModelRepository<AnyObject> {
    let tableName = "spending_model"
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
    
    override func getAll() -> Array<CSSpendingModel> {
        if (self.table != nil) {
            CSDropboxManager.syncDatastore(self.datastore)
            var error : DBError? = nil
            let data : NSArray! = self.table!.query(nil, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending model getAll error: %@", error!)
                return Array<CSSpendingModel>()
            }
            
            let dataArray = data as Array<DBRecord>
            var items = Array<CSSpendingModel>()
            for item in dataArray {
                items.append(self.modelFromDBRecord(item))
            }
            
            return items
        }
        
        return Array<CSSpendingModel>()
    }
    
    override func getAllFromDate(date: NSDate) -> Array<CSSpendingModel> {
        if (self.table != nil) {
            CSDropboxManager.syncDatastore(self.datastore)
            var error : DBError? = nil
            let data : NSArray! = self.table!.query(nil, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending model getAllFromDate error: %@", error!)
                return Array<CSSpendingModel>()
            }
            
            let dataArray = data as Array<DBRecord>
            var items = Array<CSSpendingModel>()
            for item in dataArray {
                items.append(self.modelFromDBRecord(item))
            }

            sort(&items, {
                let result = $0.timestamp.compare($1.timestamp)
                return result == NSComparisonResult.OrderedDescending
            })
            
            return items
        }
        
        return Array<CSSpendingModel>()
    }
    
    override func get(key: String) -> CSSpendingModel? {
        if (self.table != nil) {
            CSDropboxManager.syncDatastore(self.datastore)
            var error : DBError? = nil
            
            let dictionary = ["key": key] as NSDictionary
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending model get error: %@", error!);
                return nil
            }
            
            error = nil
            let data = records as Array<DBRecord>
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record != nil) {
                return self.modelFromDBRecord(record!)
            }
        }
        
        return nil
    }
    
    override func save(model: CSSpendingModel) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            
            let item = self.dictionaryFromModel(model)
    
            self.table!.insert(item)
            self.datastore!.sync(&error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending model save error: %@", error!);
                return false
            }
            
            return true
        }
        return false
    }
    
    override func remove(model: CSSpendingModel) -> Bool {
        if (self.table != nil) {
            var error : DBError? = nil
            
            let dictionary = ["key": model.key] as NSDictionary
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error != nil) {
                NSLog("[Dropbox] Spending model remove error: %@", error!);
                return false
            }
            
            error = nil
            let data = records as Array<DBRecord>
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record != nil) {
                record!.deleteRecord()
                self.datastore!.sync(&error)
                
                if (error != nil) {
                    NSLog("[Dropbox] Spending model remove error: %@", error!);
                    return false
                }
            }
            
            return true
        }
        return false
    }
    
    // Private methods
    
    private func modelFromDBRecord(dbRecord: DBRecord) -> CSSpendingModel {
        var model = CSSpendingModel(key: dbRecord["key"] as String)
        model.amount = dbRecord["amount"] as Float
        model.category = dbRecord["category"] as String?
        model.label = dbRecord["label"] as String?
        model.timestamp = dbRecord["timestamp"] as NSDate
        model.note = dbRecord["note"] as String?
        
        return model
    }
    
    private func dictionaryFromModel(model : CSSpendingModel) -> NSDictionary {
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
