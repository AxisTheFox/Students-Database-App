//
//  ViewController.swift
//  FoxBraydonAssignment4
//
//  Created by Braydon Fox on 11/7/16.
//  Copyright © 2016 Braydon Fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var studentsTableView: UITableView!
    
    var studentTableData:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        studentsTableView.delegate = self
        studentsTableView.dataSource = self
        self.title = "Students"
        let urlAsString = "http://csmadison.dhcp.bsu.edu/~vjtanksale/cs320/selectstudents.php"
        let url = URL(string: urlAsString)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            if(error != nil) {
                print(error!.localizedDescription)
            }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                    DispatchQueue.main.async(execute: {
                        self.studentTableData = jsonResult
                        self.studentsTableView.reloadData()
                    })
                }
            }
            catch {}
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier:"cell")
        let rowData:NSDictionary = (self.studentTableData[indexPath.row] as? NSDictionary)!
        cell.textLabel?.text = (rowData["FirstName"] as? String)! + " " + (rowData["LastName"] as? String)!
        return cell
    }

}

