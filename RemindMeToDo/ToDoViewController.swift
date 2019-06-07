//
//  ViewController.swift
//  RemindMeToDo
//
//  Created by Shishir Dilipkumar on 07/06/19.
//  Copyright © 2019 Shishir Dilipkumar. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    var itemArray = ["Item1","Item2","Item3"]
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "toDoItemArray") as? [String] {
            itemArray = items
        }
        
    }
    
    //MARK: - Tableview Datasource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addItemButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            textField = alertTextField
        }
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "toDoItemArray")
            self.tableView.reloadData()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

