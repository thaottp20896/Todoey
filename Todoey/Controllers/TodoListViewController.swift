//
//  ViewController.swift
//  Todoey
//
//  Created by Mỡ Mịn Màng on 2/27/20.
//  Copyright © 2020 GT. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item] ()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Wash dishes"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Clean the house"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Read the Swift book"
        itemArray.append(newItem3)

        if let item = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = item
        }
    }

    //MARK - Tableview Data sourse Methods.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title

        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse

        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    //MARK - Tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()



        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add new item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // What will happen once the user clicks the Add Item Button on our UIAlert
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
            textField = alertTextField
            //            print(alertTextField.text)
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)

    }

}

