//
//  DetailViewController.swift
//  SleepMonitor
//
//  Created by Min Zeng on 11/02/2018.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let data = SleepModel.Instance.Data
        let date = SleepModel.Instance.Date[section]
        return (data[date]?.count)!
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let data = SleepModel.Instance.Data
        let date = SleepModel.Instance.Date[indexPath.section]
        let item = data[date]![indexPath.row]
        
        let formatter = Formatter.localTime
        let startTimeStr = formatter.string(from: item.startDate)
        let endTimeStr = formatter.string(from: item.endDate)
        cell.textLabel?.text = "\(startTimeStr) - \(endTimeStr)"
        cell.detailTextLabel?.text = item.value
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return SleepModel.Instance.Date.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SleepModel.Instance.Date[section]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
}

