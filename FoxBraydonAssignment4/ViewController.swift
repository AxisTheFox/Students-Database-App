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
    
    var studentResultsData:NSArray = []
    var studentList = [Student]()
    
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
                        self.studentResultsData = jsonResult
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
        return studentResultsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier:"cell")
        let rowData:NSDictionary = (self.studentResultsData[indexPath.row] as? NSDictionary)!
        let s = Student()
        s.id = (rowData["StudentId"] as? String)!
        s.lastName = (rowData["LastName"] as? String)!
        s.firstName = (rowData["FirstName"] as? String)!
        s.major = (rowData["Major"] as? String)!
        s.year = (rowData["Year"] as? String)!
        s.gpa = (rowData["GPA"] as? String)!
        studentList.append(s)
        cell.textLabel?.text = s.firstName + " " + s.lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showStudentDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? StudentDetailsViewController
        let index = ((sender as! IndexPath) as NSIndexPath).row
        destination?.student = studentList[index]
    }

}

