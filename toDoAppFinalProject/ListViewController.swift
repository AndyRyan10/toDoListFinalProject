//
//  ListViewController.swift
//  toDoAppFinalProject
//
//  Created by Andrew Ryan on 7/26/17.
//  Copyright © 2017 AndrewRyan. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

// MARK: - Identifier Constants
    
    var toDoArray = [ToDoItem]()
    let coreDataManger = CoreDataManger()
    
    //var toDos = [NSManagedObject]()

// MARK: - Interface Builder Outlets

    @IBOutlet var toDoList: UITableView!
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let currentDate = Date()
        
        
        let titles = ["Homework 1", "Homework 2", "Homework 3", "Study for test"]
        let classes = ["Chemistry", "Biology"]
        let randomTimeInterval = Double(arc4random_uniform(864000))
        //let dueDates = currentDate+(currentDate, randomTimeInterval)
        let poms = [0, 1, 2, 3]

        let randomTitle = titles[Int(arc4random_uniform(UInt32(titles.count)))]
        let randomClass = classes[Int(arc4random_uniform(UInt32(classes.count)))]
        let randomDueDate = currentDate.addingTimeInterval(randomTimeInterval)
        let randompoms = Int32(poms[Int(arc4random_uniform(UInt32(poms.count)))])
        
        //let coreDataManager = CoreDataManger()
        
        do {
            try coreDataManger.saveToDo(randomTitle, studentClass: randomClass, dueDate: randomDueDate, pomodoros: randompoms)
            
            try toDoArray = coreDataManger.pullToDoItems() as! [ToDoItem]
            
        } catch {
            print("Error Saving ToDo")
        }
        
        self.tableView.reloadData()
        /*
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewToDoViewController")
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self
        present(viewController, animated: true, completion: nil)
 */
    }
    
// MARK: - TableView Controls

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell", for: indexPath) as! ToDoViewCell
        
        let toDo = toDoArray[indexPath.row] as ToDoItem
        cell.toDo = toDo

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let toDoForDelete = self.toDoArray[indexPath.row]
    
            let alertController = UIAlertController(title: "Confirm?", message: "Do you want to delete: \(String(describing: toDoArray[indexPath.row].title))?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
                
                do {
                 try self.coreDataManger.deleteToDoItems(toDoForDelete)
                    self.toDoArray.remove(at: indexPath.row)
                    self.toDoList.deleteRows(at: [indexPath], with: .fade)
                } catch {
                    print("error deleting item")
                }
                
                
                tableView.reloadData()
                
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true, completion: nil)
        }
        /*
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        */
     }


    
    // MARK: - Properties
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            toDoArray = try coreDataManger.pullToDoItems() as! [ToDoItem]
        } catch {
            print("Could not get students")
        }
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        //toDoArray = toDoData
        //toDoList.reloadData()
    }
    
// MARK: - Navigation
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(ListViewController.dismissViewController))
        
        //let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(ListViewController.saveViewController))
        navigationController.topViewController?.navigationItem.title = "Add To Do"
        //navigationController.topViewController?.navigationItem.rightBarButtonItem = saveButton
        navigationController.topViewController?.navigationItem.leftBarButtonItem = cancelButton
        
        return navigationController
    }

// MARK: - IBActions
// MARK: - Helper Functions
    func imageForPoms(pomodoros: Int) -> UIImage?{
        let imageName = "POM#\(pomodoros).png"
        return UIImage(named: imageName)
    }
    
    func dismissViewController() {
        
        print("cancel clicked")
        self.dismiss(animated: true, completion: nil)
        
    }

// MARK: - Delegates / Extensions
 
    
}
