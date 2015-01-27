//
//  AddTeamVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class AddTeamVC:UIViewController, UIScrollViewDelegate {
    
    
    var msg: String!
    var status: String!
    var rePasswordMatch = false
    var isWating = false
    
    @IBOutlet weak var txtTeamID: UITextField!
    @IBOutlet weak var txtTeamTitle: UITextField!
    @IBOutlet weak var txtTeamDesc: UITextField!
    @IBOutlet weak var txtTeamMembers: UITextField!
    
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var lblErrorMsg: UILabel!
    @IBOutlet weak var waitingInd: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnCancel.layer.cornerRadius = 4.0
        btnCreate.layer.cornerRadius = 4.0
        
        
        self.txtTeamID.layer.borderWidth = 1.0
        self.txtTeamTitle.layer.borderWidth = 1.0
        self.txtTeamDesc.layer.borderWidth = 1.0
        self.txtTeamMembers.layer.borderWidth = 1.0
        
        
        self.txtTeamID.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        self.txtTeamTitle.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        self.txtTeamDesc.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        self.txtTeamMembers.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        
        
        self.txtTeamID.layer.cornerRadius = 4.0
        self.txtTeamTitle.layer.cornerRadius = 4.0
        self.txtTeamDesc.layer.cornerRadius = 4.0
        self.txtTeamMembers.layer.cornerRadius = 4.0
        
        
        
        self.waitingInd.hidden = true
        
        
        self.scrollView.contentSize = self.containerView.frame.size
        //  println(self.scrollView.contentSize)
        
        
        var team1 = Team(ref: "", orgID: "mohsinTeam4", desc: "omdsoam omdsa", title: "dsafa fdsa", owner: "mmohsin", members:  ["mmohsin" : 1])
        
        wowref.asyncCreateOrganization(team1, callBack: { (errorDesc, unRegMembersUIDs) -> Void in
            if errorDesc == nil {
                println("org crated")
                println(unRegMembersUIDs)
            }
                
            else{
                println(errorDesc)
            }
        })
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        //self.imgBackground.image = backgroundImage
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        if self.isWating{
            self.lblErrorMsg.text = "please wait for response..."
        }
        else{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func create(sender: AnyObject) {
        
        
        UIView.transitionWithView(self.containerView, duration: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: {         self.containerView.frame = CGRect(x: 0.0, y: 0.0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
            
            
            }, completion: nil)
        
        if isAllFilled() {
            
            if self.isWating{
                self.lblErrorMsg.text = "please wait for response..."
            }
            else {
                self.isWating = true
                self.waitingInd.hidden = false
                self.lblErrorMsg.text = "Your team is creating please wait..."
                
            // write add team code here..
                
            }
            
        }
        else{
            var backAlert = UIAlertController(title: "Error!", message: "Kindly fill all fields.", preferredStyle: .Alert)
            
            let back = UIAlertAction(title: "Back", style: .Default, handler: nil)
            
            backAlert.addAction(back)
            
            presentViewController(backAlert, animated: true, completion: nil)
            
        }
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
    
    
    func isAllFilled() -> Bool{
        if self.txtTeamID.text != "" &&
            self.txtTeamTitle.text != "" &&
            self.txtTeamDesc.text != ""
        {
            return true
        }
            
        else{
            return false
        }
        
    }
    
    @IBAction func whenSelect(sender: UITextField) {
        sender.layer.borderColor = colorLBlue.CGColor
        // shadow on
        sender.layer.shadowRadius = 3
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        sender.layer.shadowOpacity = 0.8
        sender.layer.shadowColor = colorLBlue.CGColor
        sender.layer.masksToBounds = false
    }
    @IBAction func whenDeSelect(sender: UITextField) {
        sender.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        // shadow off
        sender.layer.masksToBounds = true
        
    }
    
    func stringToDic(string: String)-> [String : Int]{
        
        var tempArr = [String : Int]()
        
        tempArr[string] = 1
        
        return tempArr
    }
}
