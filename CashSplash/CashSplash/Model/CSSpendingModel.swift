//
//  CSSpendingModel.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 01/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSSpendingModel: NSObject {
    var key: String
    var amount: Float
    var category: String?
    var label: String?
    var timestamp: NSDate
    var note: String?
    
    init()  {
        self.key = NSUUID.UUID().UUIDString;
        self.amount = 0
        self.category = ""
        self.label = ""
        self.timestamp = NSDate.date()
        self.note = ""
    }
    
    func formattedAmount() -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter.stringFromNumber(NSNumber(float: self.amount))
    }
    
    func formattedDescription() -> String? {
        let hasCategory = self.category && countElements(self.category!) > 0
        let hasLabel = self.label && countElements(self.label!) > 0
        
        if (hasCategory && hasLabel) {
            return "\(self.category), \(self.label)"
        } else if (hasCategory) {
            return self.category
        } else if (hasLabel) {
            return self.label
        }
        return nil
    }
}
