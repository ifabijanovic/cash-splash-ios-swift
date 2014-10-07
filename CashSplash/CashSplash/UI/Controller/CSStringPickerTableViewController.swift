//
//  CSStringPickerTableViewController.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

protocol CSStringPickerDelegate: class {
    
    func stringPicker(stringPicker: CSStringPickerTableViewController, didSelectString value: String)
    
}

class CSStringPickerTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var dataSource : CSRepository<String>?
    weak var delegate : CSStringPickerDelegate?
    
    var canAddItems = true
    var isEnabled = true
    var canDeselect = true
    
    var selected : String?
    var identifier : String?
    
    private var selectedCell : UITableViewCell?
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if (!self.canAddItems) {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let delegate = self.delegate {
            if let value = self.selected {
                delegate.stringPicker(self, didSelectString: value)
            }
        }
    }
    
    // MARK: - Helper methods
    
    func refresh() {
        if let dataSource = self.dataSource {
            dataSource.refresh()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.count()
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let dataSource = self.dataSource {
            let cellIdentifier = "cell"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
            
            let items = dataSource.getAll()
            let item = items[indexPath.row]
            cell.textLabel?.text = item
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            if let selected = self.selected {
                if selected == item {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    self.selectedCell = cell
                }
            }
            
            if (!self.isEnabled) {
                cell.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            if let dataSource = self.dataSource {
                let items = dataSource.getAll()
                let item = items[indexPath.row]
                
                if dataSource.remove(item) {
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (!self.isEnabled) {
            return
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        if (self.selectedCell == selectedCell) && self.canDeselect {
            // Tapped current selection, deselect it
            self.selectedCell?.accessoryType = UITableViewCellAccessoryType.None
            self.selectedCell = nil
            self.selected = nil
            return
        }
        
        self.selectedCell?.accessoryType = UITableViewCellAccessoryType.None
        selectedCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        self.selectedCell = selectedCell
        
        if let dataSource = self.dataSource {
            let items = dataSource.getAll()
            self.selected = items[indexPath.row]
        }
    }

}
