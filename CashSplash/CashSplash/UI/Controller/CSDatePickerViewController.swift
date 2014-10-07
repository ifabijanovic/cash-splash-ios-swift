//
//  CSDatePickerViewController.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

protocol CSDatePickerDelegate: class {
    
    func setDate(date: NSDate)
    
}

class CSDatePickerViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate : CSDatePickerDelegate?
    var date : NSDate?

    // MARK: - Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Actions
    
    @IBAction func nowTapped(sender: AnyObject) {
        self.datePicker.date = NSDate.date()
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let d = self.date {
            self.datePicker.date = d
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let d = self.delegate {
            d.setDate(self.datePicker.date)
        }
    }

}
