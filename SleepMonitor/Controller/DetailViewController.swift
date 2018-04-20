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
        let data = SleepModel.Instance.SData
        let date = SleepModel.Instance.SDate[section]
        return (data[date]?.count)!
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let date = SleepModel.Instance.SDate[indexPath.section]
        cell.textLabel?.text = SleepModel.Instance.stringSleepStartEndTime(date: date, index: indexPath.row)
        cell.detailTextLabel?.text = SleepModel.Instance.stringValue(date: date, index: indexPath.row)
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return SleepModel.Instance.SDate.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SleepModel.Instance.SDate[section]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        HealthKitProvider.Instance.requestAuthorization()
//        SleepModel.Instance.loadData { (data) in
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

