//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by BhuvanaR on 5/30/23.
//

enum ToDoTasksSectionType: Int {
    case upcoming
    case ongoing
    case completed
}

protocol TodoListUpdate {
    func reloadToDoList()
}

enum ContextualActionType: CaseIterable {
    case pin
    case delete
    case edit
    case done
    
    var title: String {
        switch self {
        case .pin:
            return "Pin"
        case .delete:
            return "Delete"
        case .edit:
            return "Edit"
        case .done:
            return "Done"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .pin:
            return .systemBlue
        case .delete:
            return .systemRed
        case .edit:
            return .systemOrange
        case .done:
            return .systemGreen
        }
    }
    
    var image: String {
        switch self {
        case .pin:
            return "pin"
        case .delete:
            return "trash"
        case .edit:
            return "pencil"
        case .done:
            return "flag"
        }
    }
    
    func handleAction(completionHandler: @escaping () -> Void) {
        switch self {
        case .pin:
            handlePin()
        case .delete:
            handleMoveToTrash()
        case .edit:
            handleEdit()
        case .done:
            handleDone()
        }
        completionHandler()
    }
    
    func handlePin() {
        print("Move to Archive")
    }

    func handleMoveToTrash() {
        print("Move to Trash")
    }

    func handleEdit() {
        print("Edit clicked")
    }
    
    func handleDone() {
        print("Handle Done")
    }
    
}

import UIKit

class ToDoListViewController: UIViewController, TodoListUpdate {
    
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    var toDoTasksSectionType: ToDoTasksSectionType = .ongoing
    var toDoList = [ToDoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.register(UINib(nibName: "EmptyTasksTableCell", bundle: nil), forCellReuseIdentifier: "EmptyTasksTableCell")
        toDoTableView.register(UINib(nibName: "ToDosTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDosTableViewCell")
        loadProductsData()
    }
    
    @IBAction func AddListBtnAction(_ sender: UIButton) {
        
        if let addGamesView = self.storyboard?.instantiateViewController(withIdentifier: "AddNotesScene") as? AddNotesViewController {
            toDoTableView.reloadData()
            addGamesView.modalPresentationStyle = .overCurrentContext
            addGamesView.modalTransitionStyle = .crossDissolve
            addGamesView.todoListDelegate = self
            self.navigationController?.present(addGamesView, animated: true, completion: nil)
        }
    }
    
    @IBAction func statusSegmentedControlAction(_ sender: UISegmentedControl) {
        switch statusSegmentedControl.selectedSegmentIndex {
        case 0:
            toDoTasksSectionType = .ongoing
        case 1:
            toDoTasksSectionType = .upcoming
        case 2:
            toDoTasksSectionType = .completed
        default:
            toDoTasksSectionType = .ongoing
        }
        loadProductsData()
        self.toDoTableView.reloadData()
    }
    
    func reloadToDoList() {
        loadProductsData()
    }
    
    func loadProductsData() {
        if let toDolistData = ToDoDataManager().getToDoListDetails() {
            self.toDoList = toDolistData
            toDoTableView.reloadData()
        }
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.isEmpty ? 1 : toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if toDoList.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDosTableViewCell", for: indexPath) as! ToDosTableViewCell
            switch toDoTasksSectionType {
            case .ongoing:
                cell.toDoTitle.text = toDoList[indexPath.row].title
                cell.toDoDescription.text = toDoList[indexPath.row].start_date
            case .upcoming:
                cell.toDoTitle.text = toDoList[indexPath.row].title
                cell.toDoDescription.text = toDoList[indexPath.row].start_date
            case .completed:
                cell.toDoTitle.text = toDoList[indexPath.row].title
                cell.toDoDescription.text = toDoList[indexPath.row].start_date
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTasksTableCell", for: indexPath) as! EmptyTasksTableCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return toDoList.isEmpty ? 200.0 : 100.0
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return swipeActionHandlers(contextualActionType: [.edit])
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func swipeActionHandlers(contextualActionType: [ContextualActionType]) -> UISwipeActionsConfiguration {
        let actions: [ContextualActionType] = contextualActionType
        
        let swipeActions = actions.map { actionType -> UIContextualAction in
            let action = UIContextualAction(style: .normal, title: actionType.title) { (_, _, completionHandler) in
                actionType.handleAction {
                    completionHandler(true)
                }
            }
            action.image = UIImage(systemName: actionType.image)
            action.backgroundColor = actionType.backgroundColor
            return action
        }
        
        let configuration = UISwipeActionsConfiguration(actions: swipeActions)
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return swipeActionHandlers(contextualActionType: [.delete, .pin, .done])
    }
    
    
}
