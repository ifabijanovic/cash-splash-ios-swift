//
//  CSSpendingTableViewController.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSSpendingTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var category = ""
    private var label = ""
    private var date = NSDate.date()
    
    // MARK: - Outlets
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTextField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func saveTapped(sender: AnyObject) {
        
    }
    
    @IBAction func endEdit(sender: AnyObject) {
        
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clear()
    }
    
    // MARK: - Helper methods
    
    func clear() {
        self.amountTextField.text = ""
        self.category = ""
        self.categoryLabel.text = ""
        self.label = ""
        self.labelLabel.text = ""
        self.setDate(NSDate.date())
        self.noteTextField.text = ""
    }
    
    // MARK: - CSDatePickerDelegate
    
    func setDate(date: NSDate) {
        self.date = date
        self.dateLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.section == 2) && (indexPath.row == 0) {
            self.clear()
        }
    }

}
