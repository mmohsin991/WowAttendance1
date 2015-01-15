//
//  HomeVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit


@objc
protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}

class HomeVC: WowUIViewController {

    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnLogOut: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationItem.title = "Home"
        
        println("HomeVCload")
        
        if loginUser != nil{
            lblName.text = "\(loginUser!.firstName) \(loginUser!.lastName)"
            lblEmail.text = loginUser?.email
        }
        
      //  delegate?.collapseSidePanels!()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.imgBackground.image = backgroundImage
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func logOut(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {
            self.performSegueWithIdentifier("logoutSeg", sender: nil)
            
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logoutSeg"{
            
        }
    }

    @IBAction func rightMenu(sender: AnyObject) {
        delegate?.toggleRightPanel!()
    }
}
