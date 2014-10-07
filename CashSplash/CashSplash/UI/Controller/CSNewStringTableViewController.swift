//
//  CSNewStringTableViewController.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

protocol CSNewStringDelegate: class {
    
    func newString(newString: CSNewStringTableViewController, didSaveItem item: String)
    
}

class CSNewStringTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate : CSNewStringDelegate?
    
    var sectionTitle : String?
    var placeholdeText : String?
    
    // MARK: - Outlets
    
    @IBOutlet weak var itemTextField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func saveTapped(sender: AnyObject) {
        if self.itemTextField.text.isEmpty {
            return
        }
        
        if let delegate = self.delegate {
            delegate.newString(self, didSaveItem: self.itemTextField.text)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 44
        self.itemTextField.placeholder = self.placeholdeText
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.itemTextField.becomeFirstResponder()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitle
    }

}
