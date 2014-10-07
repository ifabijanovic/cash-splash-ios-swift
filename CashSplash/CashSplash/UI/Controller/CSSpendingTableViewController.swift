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
        self.amountTextField.resignFirstResponder()
        self.noteTextField.resignFirstResponder()
        
        let amount = NSString(string: self.amountTextField.text).floatValue // TODO: check back later if there is a Swift way to do this
        let note = self.noteTextField.text
        
        let spending = CSSpending()
        spending.amount = amount
        spending.category = self.category
        spending.label = self.label
        spending.timestamp = self.date
        spending.note = note
        
        let factory = CSDataManager.sharedManager().createRepositoryFactory()
        let repository = factory.createSpendingModelRepository()
        
        if repository.save(spending) {
            self.clear()
        }
    }
    
    @IBAction func endEdit(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 44
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
        if (value.isEmpty) {
            return
        }
        
        if (stringPicker.identifier == self.categoryIdentifier) {
            self.category = value
            self.categoryLabel.text = value
            self.tableView.cellForRowAtIndexPath(self.categoryCellIndex)?.layoutSubviews() // TODO: setNeedsLayout should work but it does not in Swift
        } else if (stringPicker.identifier == self.labelIdentifier) {
            self.label = value
            self.labelLabel.text = value
            self.tableView.cellForRowAtIndexPath(self.labelCellIndex)?.layoutSubviews() // TODO: setNeedsLayout should work but it does not in Swift
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
            controller.title = "Category"
            controller.addSectionTitle = "New category"
            controller.addPlaceholdeText = "Enter new category name here"
        } else if (segue.identifier == "pickLabelSegue") {
            let controller = segue.destinationViewController as CSStringPickerTableViewController
            controller.delegate = self
            controller.dataSource = CSDataManager.sharedManager().createRepositoryFactory().createLabelRepository()
            controller.selected = self.label
            controller.identifier = self.labelIdentifier
            controller.title = "Label"
            controller.addSectionTitle = "New label"
            controller.addPlaceholdeText = "Enter new label name here"
        }
    }

}
