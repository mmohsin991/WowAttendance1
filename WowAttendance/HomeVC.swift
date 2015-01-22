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
    
    @IBOutlet weak var lblUID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingInd: UIActivityIndicatorView!
    @IBOutlet weak var loadingLbl: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    
    
    var ownersList = [String: [NSObject : AnyObject] ]()
    var subscriberList = [String: [NSObject : AnyObject] ]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //segmrnted control default selection
        self.segmentControl.setEnabled(true, forSegmentAtIndex: 0)

        
        // table view configurations
        self.tableView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.greenColor()
        self.navigationItem.titleView = imgBarLogo
        
        // mate user image in round shape
        self.imgUser.layer.cornerRadius = self.imgUser.frame.size.width/2
        self.imgUser.layer.masksToBounds = true
        
        
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
//            if memberList != nil {
//                
//                wowref.asynGetOrgsById(["org1", "org2","sda"], callBack: { (orgList) -> Void in
//                    println(orgList!)
//                })
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
            return self.subscriberList.keys.array.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if segmentControl.selectedSegmentIndex == 0 {
            
            performSegueWithIdentifier("teamSeg", sender: self.ownersList.keys.array[indexPath.row])
        }
        else if segmentControl.selectedSegmentIndex == 1 {
            performSegueWithIdentifier("teamSeg", sender: self.subscriberList.keys.array[indexPath.row])
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //select orgs segment
        if self.segmentControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = self.ownersList.values.array[indexPath.row]["title"] as NSString
            cell.detailTextLabel?.text = self.ownersList.values.array[indexPath.row]["desc"] as NSString

        }
            
            //select subscriber segment
        else if self.segmentControl.selectedSegmentIndex == 1 {
            cell.textLabel?.text = self.subscriberList.values.array[indexPath.row]["title"] as NSString
            cell.detailTextLabel?.text = self.subscriberList.values.array[indexPath.row]["desc"] as NSString
        }
        
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        cell.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        
        cell.imageView?.layer.cornerRadius = 25
        cell.imageView?.layer.masksToBounds = true
        

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "teamSeg" {
            
            let desVC = segue.destinationViewController as TeamVC
            
            desVC.selectedOrgId = sender as String
            desVC.memberTypeWithOrg = self.segmentControl.selectedSegmentIndex
            desVC.delegate = self.delegate
        }
    }
    
    

    @IBAction func rightMenu(sender: AnyObject) {
        delegate?.toggleRightPanel!()
    }
    
    @IBAction func segmentControl(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            self.tableView.hidden = false
            self.btnAdd.setTitle("Add Org", forState: UIControlState.Normal)
            self.tableView.reloadData()
        }
        else if segment.selectedSegmentIndex == 1 {
            self.tableView.hidden = false
            self.btnAdd.setTitle("Subscribe Org", forState: UIControlState.Normal)
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func addTeam(sender: AnyObject) {
        performSegueWithIdentifier("addTeamSeg", sender: self)
    }
    
    

}
