//
//  ToDoList.swift
//  ToDoListApp
//
//  Created by Bhuvana Ravuri on 6/1/23.
//

import Foundation
import UIKit

class ToDoList {
    var title: String?
    var priority: String?
    var creation_date: String?
    var start_date: String?
    var due_date: String?
    var due_time: String?
    var completion_date: String?
    
    init(title: String? = nil, priority: String? = nil, creation_date: String? = nil, start_date: String? = nil, due_time: String? = nil, due_date: String? = nil, completion_date: String? = nil) {
        self.title = title
        self.priority = priority
        self.creation_date = creation_date
        self.start_date = start_date
        self.due_time = due_time
        self.due_date = due_date
        self.completion_date = completion_date
    }
}
