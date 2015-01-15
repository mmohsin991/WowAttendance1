//
//  ViewController.swift
//  WowAttendance
//
//  Created by Mohsin on 10/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClicked(sender: AnyObject) {
        
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        let window = appDel.window?
        
        
        let containerViewController = ContainerViewController()
        
        window!.rootViewController = containerViewController
        window!.makeKeyAndVisible()
        
        
        
//        self.dismissViewControllerAnimated(true, completion: {
//            self.presentViewController(vc, animated: true, completion: nil)
//
//        })
        
    }

}

