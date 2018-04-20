//
//  DailyTableViewController.swift
//  SleepMonitor
//
//  Created by Min Zeng on 2018/4/18.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import UIKit

class DailyTableViewController: UITableViewController {
    
    var valueToPass:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SleepModel.Instance.SDate.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath)
        
        // Configure the cell...
        let date = SleepModel.Instance.SDate[indexPath.row]
        cell.textLabel?.text = date
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = SleepModel.Instance.SDate[indexPath.row]
        valueToPass = date
        
        performSegue(withIdentifier: "ShowDailyDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDailyDetailSegue" {
            let viewController = segue.destination as! DailyViewController
            viewController.passedValue = valueToPass
        }
    }
    
}
