//
//  StatisticViewController.swift
//  TaskToday
//
//  Created by Nikita Gura on 09.12.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//

import UIKit
import Charts
import CoreData

@available(iOS 10.0, *)
final class StatisticViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Outlets
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: properties
    
   private var doneData = PieChartDataEntry(value: 0)
   private var notDoneData = PieChartDataEntry(value: 0)
   private var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
   private var tasksArrDone = [TaskDone]()
   private let fethRequestDone: NSFetchRequest<TaskDone> = TaskDone.fetchRequest()
   private var tasksArrNotDone = [TaskNotDone]()
   private let fethRequestNotDone: NSFetchRequest<TaskNotDone> = TaskNotDone.fetchRequest()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        do{
            let tasksDone = try PersistenceSerivce.context.fetch(fethRequestDone)
            self.tasksArrDone = tasksDone
            
            let tasksNotDone = try PersistenceSerivce.context.fetch(fethRequestNotDone)
            self.tasksArrNotDone = tasksNotDone
          
        } catch {}
        
        doneData.value = Double(tasksArrDone.count)
        notDoneData.value = Double(tasksArrNotDone.count)
        numberOfDownloadsDataEntries = [doneData, notDoneData]
        updateChartData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
        pieChart.chartDescription?.text = ""
        doneData.label = "Done"
        notDoneData.label = "not Done"
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - selectors
    
    @objc func changeSegment(){
        tableView.reloadData()
    }
    
    // MARK: -  methods
    
    fileprivate func updateChartData() {
        
        let chartDataSet = PieChartDataSet(values: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.green, UIColor.red]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
       
        
    }
    // MARK: - delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentControl.selectedSegmentIndex == 1){
            return tasksArrNotDone.count
                }else{
                    return tasksArrDone.count
                }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath)
        
        let firstForm = cell.frame
        
        if(segmentControl.selectedSegmentIndex == 1){
            cell.backgroundColor = UIColor.red
            cell.textLabel?.text = tasksArrNotDone[indexPath.row].text
                }else{
            cell.backgroundColor = UIColor.green
            cell.textLabel?.text = tasksArrDone[indexPath.row].text
            }
        cell.frame = CGRect(x: cell.frame.maxX / 2, y: cell.frame.maxY / 2, width: 0, height: 0)
        UIView.animate(withDuration: 1.5, delay: 0.04 * Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {
            cell.frame = firstForm
        }, completion: nil)
        
        return cell
    }
}









