//
//  ArrayExtensions.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 02/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

extension Array {
    func indexOfObject(object: AnyObject) -> Int {
        return (self as NSArray).indexOfObject(object);
    }
    
    mutating func removeObject(object: AnyObject) {
        let index = self.indexOfObject(object)
        if (index != NSNotFound) {
            self.removeAtIndex(index)
        }
    }
}
