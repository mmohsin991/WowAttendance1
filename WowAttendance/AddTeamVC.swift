//
//  AddTeamVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class AddTeamVC: UIViewController {
    
    @IBOutlet weak var imgBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.imgBackground.image = backgroundImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func back(sender: AnyObject) {
        var backAlert = UIAlertController(title: "Back!", message: "Are U sure to go back ?", preferredStyle: .Alert)
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        let no = UIAlertAction(title: "No", style: .Default, handler: nil)
        backAlert.addAction(no)
        backAlert.addAction(yes)
        
        presentViewController(backAlert, animated: true, completion: nil)
    }

    
    @IBAction func done(sender: AnyObject) {
        var doneAlert = UIAlertController(title: "Add!", message: "Are U sure to add this team ?", preferredStyle: .Alert)
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        let no = UIAlertAction(title: "No", style: .Default, handler: { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        doneAlert.addAction(no)
        doneAlert.addAction(yes)
        
        presentViewController(doneAlert, animated: true, completion: nil)
    }
    

}
