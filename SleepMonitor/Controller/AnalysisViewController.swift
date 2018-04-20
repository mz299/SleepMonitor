//
//  AnalysisViewController.swift
//  SleepMonitor
//
//  Created by Min Zeng on 2018/4/19.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        HealthKitProvider.Instance.requestAuthorization()
        SleepModel.Instance.loadData { (data) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 6
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "In last 7 days"
        case 1:
            return "In last 30 days"
        default:
            return ""
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisCell", for: indexPath)
        
        var days = 0
        switch indexPath.section {
        case 0:
            days = 7
        case 1:
            days = 30
        default:
            days = 0
        }
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Average go to bed at"
            cell.detailTextLabel?.text = SleepModel.Instance.stringAvgGoToBed(days: days)
        case 1:
            cell.textLabel?.text = "Average get up at"
            cell.detailTextLabel?.text = SleepModel.Instance.stringAvgGetUp(days: days)
        case 2:
            cell.textLabel?.text = "Average sleep for"
            cell.detailTextLabel?.text = SleepModel.Instance.stringAvgSleep(days: days)
        case 3:
            cell.textLabel?.text = "Average woke up"
            cell.detailTextLabel?.text = SleepModel.Instance.stringAvgWokeUp(days: days)
        case 4:
            cell.textLabel?.text = "Total sleep for"
            cell.detailTextLabel?.text = SleepModel.Instance.stringTotalSleep(days: days)
        case 5:
            cell.textLabel?.text = "Total woke up"
            cell.detailTextLabel?.text = SleepModel.Instance.stringTotalWokeUp(days: days)
        default:
            break
        }
        
        return cell
    }

}
