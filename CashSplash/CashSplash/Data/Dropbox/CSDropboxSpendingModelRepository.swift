//
//  CSDropboxSpendingModelRepository.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 11/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSDropboxSpendingModelRepository: CSSpendingModelRepository {
    let tableName = "spending_model"
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
    
    override func getAll() -> Array<CSSpendingModel> {
        if (self.table) {
            // Sync here
            var error : DBError? = nil
            let data : NSArray! = self.table!.query(nil, error: &error)
            
            if (error) {
                NSLog("[Dropbox] Spending model getAll error: %@", error!)
                return Array<CSSpendingModel>()
            }
            
            let dataArray = Array<DBRecord>.bridgeFromObjectiveC(data)
            var items = Array<CSSpendingModel>()
            for item in dataArray {
                items.append(self.modelFromDBRecord(item))
            }
            
            return items
        }
        
        return Array<CSSpendingModel>()
    }
    
    override func getAllFromDate(date: NSDate) -> Array<CSSpendingModel> {
        if (self.table) {
            // Sync here
            var error : DBError? = nil
            let data : NSArray! = self.table!.query(nil, error: &error)
            
            if (error) {
                NSLog("[Dropbox] Spending model getAllFromDate error: %@", error!)
                return Array<CSSpendingModel>()
            }
            
            let dataArray = Array<DBRecord>.bridgeFromObjectiveC(data)
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
        if (self.table) {
            // Sync here
            var error : DBError? = nil
            
            let item = ["key": key]
            let dictionary = item.bridgeToObjectiveC()
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error) {
                NSLog("[Dropbox] Spending model get error: %@", error!);
                return nil
            }
            
            error = nil
            let data = Array<DBRecord>.bridgeFromObjectiveC(records)
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record) {
                return self.modelFromDBRecord(record!)
            }
        }
        
        return nil
    }
    
    override func save(model: CSSpendingModel) -> Bool {
        if (self.table) {
            var error : DBError? = nil
            
            let item = self.dictionaryFromModel(model)
    
            self.table!.insert(item)
            self.datastore!.sync(&error)
            
            if (error) {
                NSLog("[Dropbox] Spending model save error: %@", error!);
                return false
            }
            
            return true
        }
        return false
    }
    
    override func remove(model: CSSpendingModel) -> Bool {
        if (self.table) {
            var error : DBError? = nil
            
            let item = ["key": model.key]
            let dictionary = item.bridgeToObjectiveC()
            let records : NSArray! = self.table!.query(dictionary, error: &error)
            
            if (error) {
                NSLog("[Dropbox] Spending model remove error: %@", error!);
                return false
            }
            
            error = nil
            let data = Array<DBRecord>.bridgeFromObjectiveC(records)
            let record : DBRecord? = data.isEmpty ? nil : data[0]
            if (record) {
                record!.deleteRecord()
                self.datastore!.sync(&error)
                
                if (error) {
                    NSLog("[Dropbox] Spending model remove error: %@", error!);
                    return false
                }
            }
            
            return true
        }
        return false
    }
    
    // Private methods
    
    func modelFromDBRecord(dbRecord: DBRecord) -> CSSpendingModel {
        var model = CSSpendingModel()
        model.key = dbRecord["key"] as String
        model.amount = dbRecord["amount"] as Float
        model.category = dbRecord["category"] as String?
        model.label = dbRecord["label"] as String?
        model.timestamp = dbRecord["timestamp"] as NSDate
        model.note = dbRecord["note"] as String?
        
        return model
    }
    
    func dictionaryFromModel(model : CSSpendingModel) -> NSDictionary {
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
