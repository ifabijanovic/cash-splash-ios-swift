//
//  CSDropboxSpendingSerializer.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 06/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

internal class CSDropboxSpendingSerializer<T: Equatable>: CSSerializer<CSSpending> {
    
    // MARK: - Public methods
    
    internal override func serialize(item: CSSpending) -> NSDictionary {
        var dictionary = NSDictionary()
        dictionary.setValue(item.key, forKey: "key")
        dictionary.setValue(NSNumber(float: item.amount), forKey: "amount")
        dictionary.setValue(item.category, forKey: "category")
        dictionary.setValue(item.label, forKey: "label")
        dictionary.setValue(item.timestamp, forKey: "timestamp")
        dictionary.setValue(item.note, forKey: "note")
        
        return dictionary
    }
    
    internal override func deserialize(block: NSDictionary) -> CSSpending {
        var model = CSSpending(key: block["key"] as String)
        model.amount = block["amount"] as Float
        model.category = block["category"] as String?
        model.label = block["label"] as String?
        model.timestamp = block["timestamp"] as NSDate
        model.note = block["note"] as String?
        
        return model
    }
    
}
