//
//  StudentDetailsViewController.swift
//  FoxBraydonAssignment4
//
//  Created by Braydon Fox on 12/1/16.
//  Copyright © 2016 Braydon Fox. All rights reserved.
//

import UIKit

class StudentDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    
    var student:Student? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = nil
        nameLabel.text = (student?.firstName)! + " " + (student?.lastName)!
        idLabel.text = student?.id
        majorLabel.text = student?.major
        yearLabel.text = student?.year
        gpaLabel.text = student?.gpa
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
