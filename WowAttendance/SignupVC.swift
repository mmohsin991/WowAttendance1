//
//  SignupVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class SignupVC: UIViewController, UIScrollViewDelegate {

    
    var msg: String!
    var status: String!
    
    
    @IBOutlet weak var txtUID: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    
    @IBOutlet weak var imgBackground: UIImageView!

    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var waitingInd: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnCancel.layer.cornerRadius = 4.0
        btnCreate.layer.cornerRadius = 4.0

        self.waitingInd.hidden = true

        //self.scrollView.bounds.size = self.view.frame.size

        self.scrollView.contentSize = self.containerView.frame.size
      //  println(self.scrollView.contentSize)

        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.imgBackground.image = backgroundImage
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func create(sender: AnyObject) {
    }
    
    
    @IBAction func txtFieldEditing(sender: UITextField) {
        
        var changeInYaxis : CGFloat {
            if sender.frame.origin.y > 150{
                return sender.frame.origin.y - 150.0
            }
            else{
                return 0
            }
        }
        
        UIView.transitionWithView(self.containerView, duration: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: {         self.containerView.frame = CGRect(x: 0.0, y: -changeInYaxis, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)

            
            }, completion: nil)
    }
//    @IBAction func passwordEditingComplete(sender: AnyObject) {
//        UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: {         self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
//            }, completion: nil)
//    }


}
