//
//  TableViewController.swift
//  Todoey
//
//  Created by MacBookPro on 13.12.18.
//  Copyright © 2018 Gregor Mangelsdorf. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

let realm = try! Realm()
var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    

    
    
    // MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            let alert = UIAlertController(title: "Create New List", message: "", preferredStyle: .alert)
            var textfield = UITextField()
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newCategory = Category()
                newCategory.name = textfield.text!
                self.save(category: newCategory)
                self.tableView.reloadData()
            }
            alert.addTextField { (addTextField) in
                textfield = addTextField
                addTextField.placeholder = "New List"
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    
    
    
    
    // MARK: - TableViewDatasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return categories?.count ?? 1
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        return cell
    }
    
    
    
    
    // MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Some error happend: \(error)")
        }
    }
    
    
    
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    
    
    
    // MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    
    
    
    
}
