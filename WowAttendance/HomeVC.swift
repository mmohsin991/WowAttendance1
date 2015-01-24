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

class HomeVC: WowUIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingInd: UIActivityIndicatorView!
    @IBOutlet weak var loadingLbl: UIButton!
    
    
    var ownersList = [String: [String: String]]()
    var subscriber = [String: Int]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //segmrnted control default selection
        self.segmentControl.setEnabled(true, forSegmentAtIndex: 0)

        
        // table view configurations
        self.tableView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        
        //self.navigationController?.navigationBar.backgroundColor = UIColor.greenColor()
        self.navigationItem.titleView = imgBarLogo
        
<<<<<<< HEAD
        println("HomeVCload")
        
        if loginUser != nil{
            lblName.text = "\(loginUser!.firstName) \(loginUser!.lastName)"
            lblEmail.text = loginUser?.email
            
        }
        
      //  delegate?.collapseSidePanels!()
        
        // load the orgs and subscriber list
        wowref.asyncGetUsesOwnerOrgsList("zia", callBack: { (ownersList) -> Void in
            if ownersList != nil {
                self.ownersList = ownersList!
                self.tableView.reloadData()
                
                // stop and hide the loading indicators 
                self.loadingInd.stopAnimating()
                self.loadingLbl.hidden = true
            }
        })
=======
        // made user image in round shape
        self.imgUser.layer.cornerRadius = self.imgUser.frame.size.width/2
        self.imgUser.layer.masksToBounds = true
        
        self.btnAdd.layer.cornerRadius = self.btnAdd.frame.size.width/2
//        self.btnAdd.layer.shadowRadius = 1
//        self.btnAdd.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.btnAdd.layer.shadowOpacity = 0.8
//        self.btnAdd.layer.shadowColor = UIColor.darkGrayColor().CGColor
//        self.btnAdd.layer.masksToBounds = false
        
      //  delegate?.collapseSidePanels!()
        
//        // load the orgs list
//         wowref.asyncGetUsesOwnerMemberOrgsList("zia", callBack: { (ownersList, memberList) -> Void in
//            if ownersList != nil {
//                self.ownersList = ownersList!
//                self.tableView.reloadData()
//                
//                println(memberList)
//                
//                // stop and hide the loading indicators
//                self.loadingInd.stopAnimating()
//                self.loadingLbl.hidden = true
//                
//            }
//
//         })
        
    
        if loginUser == nil {
            loginUser = User(ref: "", uID: "shezi", email: "shahzadscs@gmail.com", firstName: "Shahzad", lastName: "Soomro", status: "pending")
        }
            loginUser?.asynGetSubscriberOrgs({ (orgList) -> Void in
                if orgList != nil {
                    
                    self.subscriberList = orgList!
                    self.tableView.reloadData()
                    
                    // stop and hide the loading indicators
                    self.loadingInd.stopAnimating()
                    self.loadingLbl.hidden = true
                }
                
            })
            
            loginUser?.asynGetOwnerOrgs({ (orgList) -> Void in
                
                if orgList != nil {
                    self.ownersList = orgList!
                    self.tableView.reloadData()
                    
                    
                    // stop and hide the loading indicators
                    self.loadingInd.stopAnimating()
                    self.loadingLbl.hidden = true
                    
                }
                
            })

    
        if loginUser != nil{
            lblUID.text = "@\(loginUser!.uID)"
            lblName.text = "\(loginUser!.firstName) \(loginUser!.lastName)"
            lblEmail.text = loginUser!.email
        }
>>>>>>> NewTheme
    }
    
    override func viewWillAppear(animated: Bool) {
     //   self.imgBackground.image = backgroundImage
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //select orgs segment
        if self.segmentControl.selectedSegmentIndex == 0 {
            return self.ownersList.keys.array.count
        }
        
        //select subscriber segment
        else if self.segmentControl.selectedSegmentIndex == 1 {
            return self.subscriber.keys.array.count
        }
        
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //select orgs segment
        if self.segmentControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = self.ownersList.values.array[indexPath.row]["title"]
            cell.detailTextLabel?.text = self.ownersList.values.array[indexPath.row]["desc"]

        }
            
            //select subscriber segment
        else if self.segmentControl.selectedSegmentIndex == 1 {
            cell.textLabel?.text = self.subscriber.keys.array[indexPath.row]
            cell.detailTextLabel?.text = self.ownersList.values.array[indexPath.row].description
        }
        
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        cell.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
<<<<<<< HEAD
=======
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "teamSeg" {
            
            let desVC = segue.destinationViewController as TeamVC
            
            desVC.selectedOrgId = sender as String
            desVC.memberTypeWithOrg = self.segmentControl.selectedSegmentIndex
            desVC.delegate = self.delegate
        }
    }
    
    
    
    func subscribeOrg() {
        var subscribeAlert = UIAlertController(title: "Subscribe Org", message: "Write Org Id Below", preferredStyle: .Alert)
        
        subscribeAlert.addTextFieldWithConfigurationHandler { (txtOrgId) -> Void in
            txtOrgId.placeholder = "Org Id"
            
            //            txtOrgId.layer.borderWidth = 2.0
            //            txtOrgId.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
            //            txtOrgId.layer.cornerRadius = 4.0
            //
            //
            //            // shadow on
            //            txtOrgId.layer.shadowRadius = 3
            //            txtOrgId.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            //            txtOrgId.layer.shadowOpacity = 0.8
            //            txtOrgId.layer.shadowColor = colorLBlue.CGColor
            //            txtOrgId.layer.masksToBounds = false
        }
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { _ in
            
            let txtOrgId = subscribeAlert.textFields![0] as UITextField
            
            println(txtOrgId.text)
            // add subscribe function here
            
            
        })
        let no = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil)
        subscribeAlert.addAction(no)
        subscribeAlert.addAction(yes)
        
        presentViewController(subscribeAlert, animated: true, completion: nil)
    }
>>>>>>> NewTheme

    @IBAction func rightMenu(sender: AnyObject) {
        delegate?.toggleRightPanel!()
    }
    
    @IBAction func segmentControl(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            self.tableView.hidden = false
            self.btnAdd.hidden = false
            self.tableView.reloadData()
        }
        else if segment.selectedSegmentIndex == 1 {
            self.tableView.hidden = false
            self.btnAdd.hidden = true
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func addTeam(sender: AnyObject) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            performSegueWithIdentifier("addOrgSeg", sender: self)
        }
        else if segmentControl.selectedSegmentIndex == 1 {
            // func to subscribe org
             subscribeOrg()
        }
    }
<<<<<<< HEAD
    
=======

>>>>>>> NewTheme

}
