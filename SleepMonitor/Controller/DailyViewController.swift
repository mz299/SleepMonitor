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
            if let data = SleepModel.Instance.SData[passedValue] {
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
            cell.textLabel?.text = SleepModel.Instance.stringSleepStartEndTime(date: passedValue, index: indexPath.row)
            cell.detailTextLabel?.text = SleepModel.Instance.stringValue(date: passedValue, index: indexPath.row)
        }
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Go to bed at"
                cell.detailTextLabel?.text = SleepModel.Instance.stringGoToBed(date: passedValue)
                
            case 1:
                cell.textLabel?.text = "Get up at"
                cell.detailTextLabel?.text = SleepModel.Instance.stringGetUp(date: passedValue)
                
            case 2:
                cell.textLabel?.text = "Sleep for"
                cell.detailTextLabel?.text = SleepModel.Instance.stringTotalSleepTime(date: passedValue)
                
            case 3:
                cell.textLabel?.text = "Woke up"
                cell.detailTextLabel?.text = SleepModel.Instance.stringWokeUpTime(date: passedValue)
                
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
