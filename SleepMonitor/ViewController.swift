//
//  ViewController.swift
//  SleepMonitor
//
//  Created by Min Zeng on 11/02/2018.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let list = ["SleepInfo"]
    
    @IBAction func GetInfo(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(list.count)
        
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        let cell = SleepTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SleepTableViewCell
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

