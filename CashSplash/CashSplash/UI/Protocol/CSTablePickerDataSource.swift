//
//  CSTablePickerDataSource.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 27/08/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

protocol CSTablePickerDataSource {
    
    typealias ItemType
    func items() -> Array<ItemType>
    func count() -> Int
    func save(item: ItemType) -> Bool
    func remove(item: ItemType) -> Bool
    
}
