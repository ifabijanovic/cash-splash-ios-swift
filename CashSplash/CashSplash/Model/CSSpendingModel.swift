//
//  CSSpendingModel.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 01/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

public class CSSpendingModel : Equatable {
    
    // Properties
    
    public let key: String
    public var amount: Float
    public var category: String?
    public var label: String?
    public var timestamp: NSDate
    public var note: String?
    
    // Computed properties
    
    public var formattedAmount: String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter.stringFromNumber(NSNumber(float: self.amount))
    }
    
    public var formattedDescription: String? {
        let hasCategory = self.category != nil && countElements(self.category!) > 0
        let hasLabel = self.label != nil && countElements(self.label!) > 0
        
        if (hasCategory && hasLabel) {
            return "\(self.category), \(self.label)"
        } else if (hasCategory) {
            return self.category
        } else if (hasLabel) {
            return self.label
        }
        return nil
    }
    
    // Init
    
    public init() {
        self.key = NSUUID.UUID().UUIDString;
        self.amount = 0
        self.category = ""
        self.label = ""
        self.timestamp = NSDate.date()
        self.note = ""
    }
    
    public init(key: String) {
        self.key = key
        self.amount = 0
        self.category = ""
        self.label = ""
        self.timestamp = NSDate.date()
        self.note = ""
    }
}

// Equatable

public func ==(lhs: CSSpendingModel, rhs: CSSpendingModel) -> Bool {
    return lhs.key == rhs.key
}
