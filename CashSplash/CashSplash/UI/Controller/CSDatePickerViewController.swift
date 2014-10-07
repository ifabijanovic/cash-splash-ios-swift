//
//  CSDatePickerViewController.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

protocol CSDatePickerDelegate: class {
    
    func datePicker(datePicker: CSDatePickerViewController, didSelectDate date: NSDate)
    
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

        if let date = self.date {
            self.datePicker.date = date
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let delegate = self.delegate {
            delegate.datePicker(self, didSelectDate: self.datePicker.date)
        }
    }

}
