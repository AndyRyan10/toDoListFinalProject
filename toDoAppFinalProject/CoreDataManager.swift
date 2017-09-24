//
//  CoreDataManager.swift
//  toDoAppFinalProject
//
//  Created by Andrew Ryan on 9/1/17.
//  Copyright © 2017 AndrewRyan. All rights reserved.
//

import Foundation
import CoreData
import UIKit


//dueDate
//title
//studentClass
//pomodoros

class CoreDataManger {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var dataContext: NSManagedObjectContext {
        
        let dataContext = appDelegate.persistentContainer.viewContext
        return dataContext
    }
    
    func saveToDo(_ toDoTitle: String?, studentClass: String?, dueDate: Date?, pomodoros: Int32?) throws {
        
        if let entity = NSEntityDescription.entity(forEntityName: "ToDoItem", in: dataContext) {
            
            let newToDo = NSManagedObject(entity: entity, insertInto: dataContext)
            
            newToDo.setValue(toDoTitle, forKey: forKey.title.rawValue)
            newToDo.setValue(studentClass, forKey: forKey.studentClass.rawValue)
            newToDo.setValue(dueDate, forKey: forKey.dueDate.rawValue)
            newToDo.setValue(pomodoros, forKey: forKey.pomodoros.rawValue)
            appDelegate.saveContext()
            
        }
    }
    
    func pullToDoItems() throws -> [NSManagedObject]{
        
        var toDoItemArray = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItem")
        
        do {
            let results = try dataContext.fetch(fetchRequest)
            
            toDoItemArray = results as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Fetching Error: \(error.userInfo)")
        }
        
        return toDoItemArray
    }
    
    func deleteToDoItems(_ toDoForDelete: ToDoItem) throws {
        let fetchRequest: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        do {
            let array_toDoItems = try dataContext.fetch(fetchRequest)
            
            for toDoItem in array_toDoItems as [NSManagedObject] {
                if toDoItem == toDoForDelete {
                    dataContext.delete(toDoItem)
                }
            }
            
            do {
                try dataContext.save()
                print("deleted and saved")
            } catch let error as NSError {
                print("could not save \(error), \(error.userInfo)")
            } catch {
                
            }

        }
        
            }
    
    enum forKey: String {
        case dueDate
        case title
        case studentClass
        case pomodoros
    }
}
