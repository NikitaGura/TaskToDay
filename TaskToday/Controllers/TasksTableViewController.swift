//
//  TasksTableViewController.swift
//  TaskToday
//
//  Created by Nikita Gura on 04.12.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class TasksTableViewController: UITableViewController {
    
    private var tasksArr = [Task]()
    private let fethRequest: NSFetchRequest<Task> = Task.fetchRequest()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
        do{
            let tasks = try PersistenceSerivce.context.fetch(fethRequest)
            self.tasksArr = tasks
            self.tableView.reloadData()
        } catch {}
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tasksArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath)
        
        cell.textLabel?.text = tasksArr[indexPath.row].text
        
        cell.transform = CGAffineTransform(translationX: 0, y: self.tableView.bounds.size.height)
        
        UIView.animate(withDuration: 1.5, delay: 0.04 * Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0);
        }, completion: nil)
        
        return cell
    }
    
    
    /// from task to done/note task and removing data from table view
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.saveDataCore(taskT: TaskNotDone(context: PersistenceSerivce.context), indexPath: indexPath)
        }
        
        let done = UITableViewRowAction(style: .destructive, title: "Done") { (action, indexPath) in
    
            self.saveDataCore(taskT: TaskDone(context: PersistenceSerivce.context), indexPath: indexPath)
        }

        done.backgroundColor = UIColor.green
        
        return [delete, done]
    }
    
    // MARK: - method
    
    fileprivate func saveDataCore(taskT: TaskProtocol, indexPath: IndexPath){
        var task = taskT
        task.text = self.tasksArr[indexPath.row].text
        task.dateTo = self.tasksArr[indexPath.row].dateTo
        task.dateFrom = self.tasksArr[indexPath.row].dateFrom
        
        PersistenceSerivce.context.delete(self.tasksArr[indexPath.row])
        self.tasksArr.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        PersistenceSerivce.saveContext()
    }
}


