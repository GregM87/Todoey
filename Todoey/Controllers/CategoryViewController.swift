//
//  TableViewController.swift
//  Todoey
//
//  Created by MacBookPro on 13.12.18.
//  Copyright © 2018 Gregor Mangelsdorf. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    
 var categories = [Category]()
 let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    

    // MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
            let alert = UIAlertController(title: "Create New List", message: "", preferredStyle: .alert)
            var textfield = UITextField()
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newItem = Category(context: self.context)
                newItem.name = textfield.text
                self.categories.append(newItem)
                self.saveCategory()
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
       return categories.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    // MARK: - Data Manipulation Methods
    
    func saveCategory() {
        
        do {
           try context.save()
        } catch {
            print("Some error happend: \(error)")
        }
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest() ) {
        
        do {
           categories = try context.fetch(request)
        } catch {
            print("Some error happend: \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    
    // MARK: - TableViewDelegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
            print(categories[indexPath.row])
        }
    }
    
    
}
