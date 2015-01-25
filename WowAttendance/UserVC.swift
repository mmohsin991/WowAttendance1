//
//  UserVC.swift
//  WowAttendance
//
//  Created by Mohsin on 24/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class UserVC: UIViewController {
    
    
    var uID = String()
    var name = String()
    var desc = String()

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUID: UILabel!
    @IBOutlet weak var lblUserInfo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblName.text = self.name
        self.lblUID.text = self.uID
        self.lblUserInfo.text = self.desc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func back(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
