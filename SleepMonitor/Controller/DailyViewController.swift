//
//  DailyViewController.swift
//  SleepMonitor
//
//  Created by Min Zeng on 2018/4/18.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passedValue:String!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            if let data = SleepModel.Instance.Data[passedValue] {
                return data.count
            }
        }
        
        if section == 1 {
            return 4
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyDetailCell", for: indexPath)
        
        if indexPath.section == 0 {
            if let data = SleepModel.Instance.Data[passedValue] {
                let item = data[indexPath.row]
                let formatter = Formatter.localTime
                let startTimeStr = formatter.string(from: item.startDate)
                let endTimeStr = formatter.string(from: item.endDate)
                cell.textLabel?.text = "\(startTimeStr) - \(endTimeStr)"
                cell.detailTextLabel?.text = item.value
            }
        }
        
        if indexPath.section == 1 {
            let data = SleepModel.Instance.Data[passedValue]
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Go to bed at"
                let item = data![(data?.count)! - 1]
                let formatter = Formatter.localTime
                let startTimeStr = formatter.string(from: item.startDate)
                cell.detailTextLabel?.text = startTimeStr
                
            case 1:
                cell.textLabel?.text = "Get up at"
                let item = data![0]
                let formatter = Formatter.localTime
                let endTimeStr = formatter.string(from: item.endDate)
                cell.detailTextLabel?.text = endTimeStr
                
            case 2:
                cell.textLabel?.text = "Total sleep time"
                var totalSleepTime:TimeInterval = 0.0
                for item in data! {
                    totalSleepTime = totalSleepTime + item.endDate.timeIntervalSince(item.startDate)
                }
                cell.detailTextLabel?.text = totalSleepTime.stringTime
                
            case 3:
                cell.textLabel?.text = "Woke up"
                let wokeUpTime = max(0, (data?.count)! - 1)
                if wokeUpTime > 1 {
                    cell.detailTextLabel?.text = "\(wokeUpTime) Times"
                } else {
                    cell.detailTextLabel?.text = "\(wokeUpTime) Time"
                }
                
            default:
                break
            }
        }
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}
