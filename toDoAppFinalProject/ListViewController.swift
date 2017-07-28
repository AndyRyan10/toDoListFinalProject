//
//  ListViewController.swift
//  toDoAppFinalProject
//
//  Created by Andrew Ryan on 7/26/17.
//  Copyright © 2017 AndrewRyan. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

// MARK: - Identifier Constants
    
    var toDos: [ToDoItem] = toDoData

// MARK: - Interface Builder Outlets

    @IBOutlet var toDoList: UITableView!
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewToDoViewController")
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
// MARK: - TableView Controls

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell", for: indexPath) as! ToDoViewCell
        
        let toDo = toDos[indexPath.row] as ToDoItem
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
        
        
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    

    
    // MARK: - Properties
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        toDos = toDoData
        toDoList.reloadData()
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
