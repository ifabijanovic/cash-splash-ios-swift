//
//  CSSpendingTableViewController.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSSpendingTableViewController: UITableViewController, CSDatePickerDelegate, CSStringPickerDelegate {
    
    // MARK: - Constants
    
    private let categoryIdentifier = "category"
    private let labelIdentifier = "label"
    
    private let categoryCellIndex = NSIndexPath(forRow: 0, inSection: 1)
    private let labelCellIndex = NSIndexPath(forRow: 1, inSection: 1)
    
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
    
    func setDate(date: NSDate) {
        self.date = date
        self.dateLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    // MARK: - CSDatePickerDelegate
    
    func datePicker(datePicker: CSDatePickerViewController, didSelectDate date: NSDate) {
        self.setDate(date)
    }
    
    // MARK: - CSStringPickerDelegate
    
    func stringPicker(stringPicker: CSStringPickerTableViewController, didSelectString value: String) {
        if (stringPicker.identifier == self.categoryIdentifier) {
            self.category = value
            self.categoryLabel.text = value
            self.tableView.cellForRowAtIndexPath(self.categoryCellIndex)?.setNeedsLayout()
        } else if (stringPicker.identifier == self.labelIdentifier) {
            self.label = value
            self.labelLabel.text = value
            self.tableView.cellForRowAtIndexPath(self.labelCellIndex)?.setNeedsLayout()
        }
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.section == 2) && (indexPath.row == 0) {
            self.clear()
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.amountTextField.resignFirstResponder()
        self.noteTextField.resignFirstResponder()
        
        if (segue.identifier == "pickDateSegue") {
            let controller = segue.destinationViewController as CSDatePickerViewController
            controller.delegate = self
            controller.date = self.date
        } else if (segue.identifier == "pickCategorySegue") {
            let controller = segue.destinationViewController as CSStringPickerTableViewController
            controller.delegate = self
            controller.dataSource = CSDataManager.sharedManager().createRepositoryFactory().createCategoryRepository()
            controller.selected = self.category
            controller.identifier = self.categoryIdentifier
        } else if (segue.identifier == "pickLabelSegue") {
            let controller = segue.destinationViewController as CSStringPickerTableViewController
            controller.delegate = self
            controller.dataSource = CSDataManager.sharedManager().createRepositoryFactory().createLabelRepository()
            controller.selected = self.label
            controller.identifier = self.labelIdentifier
        }
    }

}
