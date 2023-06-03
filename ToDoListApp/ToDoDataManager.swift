//
//  ToDoDataManager.swift
//  ToDoListApp
//
//  Created by Bhuvana Ravuri on 6/1/23.
//

import Foundation
import CoreData
import UIKit

class ToDoDataManager {
    
    var coreDataManager = CoreDataManager()
    
    var context: NSManagedObjectContext {
        return coreDataManager.persistentContainer.viewContext
    }
    
    func addToDoList(toDoList: ToDoList?) {
        if let toDoData = NSEntityDescription.insertNewObject(forEntityName: "ToDoData", into: context) as? ToDoData {
            toDoData.title = toDoList?.title
            toDoData.start_date = toDoList?.start_date
            toDoData.due_date = toDoList?.due_date
            toDoData.due_time = toDoList?.due_time
            toDoData.priority = toDoList?.priority
            toDoData.completion_date = toDoList?.completion_date
            toDoData.creation_date = toDoList?.creation_date
            coreDataManager.saveContext()
        }
    }
    
    func getToDoListDetails() -> [ToDoData]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoData")
        if let getToDoList = try? context.fetch(fetchRequest) as? [ToDoData] {
            return getToDoList
        }
        return nil
    }
    
    func deleteAllToDoLists()  {
        let cartObj = getToDoListDetails()
        if let count = cartObj?.count{
            for i in 0..<count{
                context.delete(cartObj![i])
                coreDataManager.saveContext()
            }
        }
    }
    
}

