//
//  TeamVC.swift
//  WowAttendance
//
//  Created by Mohsin on 22/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class TeamVC: WowUIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var lblOrgID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingInd: UIActivityIndicatorView!
    @IBOutlet weak var loadingLbl: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    
    
    var teamList = Dictionary<NSObject , AnyObject>()
    var memberList = Dictionary<NSObject , AnyObject>()
    
    // value set by previous 
    var selectedOrgId = String()
    var memberTypeWithOrg : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //segmrnted control default selection
        self.segmentControl.setEnabled(true, forSegmentAtIndex: 0)
        
        
        // table view configurations
        self.tableView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        
       // self.navigationController?.navigationBar.backgroundColor = UIColor.greenColor()
        self.navigationItem.titleView = imgBarLogo
        
        // mate user image in round shape
        self.imgUser.layer.cornerRadius = self.imgUser.frame.size.width/2
        self.imgUser.layer.masksToBounds = true
            
        
        
        println(selectedOrgId)
        
        if loginUser != nil {
            
            // if user's owner org clicked
            if self.memberTypeWithOrg == 0 {
                
                wowref.asynGetOrgById(self.selectedOrgId, callBack: { (orgList, observerHandle, orgRef) -> Void in
                    if orgList != nil {
                        println("handel at team \(observerHandle)")
                        
                        let tempOrgs :  [String: [NSObject : AnyObject] ] = orgList!
                        let selectedOrg = tempOrgs[self.selectedOrgId]!
                        
                        // set the name, title and desc of selected org
                        let name = selectedOrg["title"] as NSString
                        let desc = selectedOrg["desc"] as NSString
                        self.setDesc("@\(self.selectedOrgId)", name: name, desc: desc)
                        
                        if selectedOrg["teams"] != nil {
                            self.teamList = (selectedOrg["teams"] as NSDictionary) as Dictionary
                        }
                        
                        if selectedOrg["members"] != nil{
                            self.memberList = (selectedOrg["members"] as NSDictionary) as Dictionary
                        }
                        
                        
                        self.tableView.reloadData()
                        
                        // stop and hide the loading indicators
                        self.loadingInd.stopAnimating()
                        self.loadingLbl.hidden = true
                        
                    }
                })
            }
            
            // if user's subscriber org clicked
            else if self.memberTypeWithOrg == 1 {
                
                wowref.asynGetOrgById(self.selectedOrgId, callBack: { (orgList, observerHandle, orgRef) -> Void in
                    if orgList != nil {
                        
                        let tempOrgs :  [String: [NSObject : AnyObject] ] = orgList!
                        let selectedOrg = tempOrgs[self.selectedOrgId]!
                        
                        // set the name, title and desc of selected org
                        let name = selectedOrg["title"] as NSString
                        let desc = selectedOrg["desc"] as NSString
                        
                        self.setDesc("@\(self.selectedOrgId)", name: name, desc: desc)
                        
                        if selectedOrg["teams"] != nil {
                            self.teamList = (selectedOrg["teams"] as NSDictionary) as Dictionary
                        }
                        
                        if selectedOrg["members"] != nil{
                            self.memberList = (selectedOrg["members"] as NSDictionary) as Dictionary
                        }
                        
                        
                        self.tableView.reloadData()
                        
                        // stop and hide the loading indicators
                        self.loadingInd.stopAnimating()
                        self.loadingLbl.hidden = true
                        
                    }
                    
                })
            }

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //select teams segment
        if self.segmentControl.selectedSegmentIndex == 0 {
            return self.memberList.keys.array.count
        }
            
            //select members segment
        else if self.segmentControl.selectedSegmentIndex == 1 {
            return self.teamList.keys.array.count

        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if segmentControl.selectedSegmentIndex == 0 {
            
            performSegueWithIdentifier("userSeg", sender: self.memberList.keys.array[indexPath.row])
        }
        else if segmentControl.selectedSegmentIndex == 1 {
            performSegueWithIdentifier("subTeamSeg", sender: self.teamList.keys.array[indexPath.row])
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //select member segment
        if self.segmentControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = "@\(self.memberList.keys.array[indexPath.row] as NSString)"
            
            if  self.memberList.values.array[indexPath.row]["firstName"] != nil {
                let firstName = self.memberList.values.array[indexPath.row]["firstName"] as NSString
                let lastName = self.memberList.values.array[indexPath.row]["lastName"] as NSString
                cell.detailTextLabel?.text = "\(firstName) \(lastName)"
            }

            cell.imageView?.image = UIImage(named: "user")
            
        }
            
            //select teams segment
        else if self.segmentControl.selectedSegmentIndex == 1 {
            cell.textLabel?.text = self.teamList.values.array[indexPath.row]["title"] as NSString
            cell.detailTextLabel?.text = self.teamList.values.array[indexPath.row]["desc"] as NSString
            
            cell.imageView?.image = UIImage(named: "team")

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
    
    
    func setDesc (orgID: String, name: String, desc: String) {
        lblOrgID.text = orgID
        lblName.text = name
        lblDesc.text = desc
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "subTeamSeg" {
            
            let desVC = segue.destinationViewController as SubTeamVC
            desVC.selectedOrgId = self.selectedOrgId
            desVC.selectedTeamId = sender as String
            desVC.memberTypeWithOrg = self.memberTypeWithOrg
            desVC.orgMemberList = self.memberList
            desVC.delegate = self.delegate
        }
        
        else if segue.identifier == "userSeg" {
            
            let desVC = segue.destinationViewController as UserVC
            let selectedRow = self.tableView.indexPathsForSelectedRows()![0].row
            
            desVC.uID = "@\(self.memberList.keys.array[selectedRow] as NSString)"
            // if user firstname and lastname available
            if  self.memberList.values.array[selectedRow]["firstName"] != nil {
                let firstName = self.memberList.values.array[selectedRow]["firstName"] as NSString
                let lastName = self.memberList.values.array[selectedRow]["lastName"] as NSString
                desVC.name = "\(firstName) \(lastName)"
            }
        }
    }
    
    func addMember() {
        var subscribeAlert = UIAlertController(title: "Add Member", message: "Write member Id Below", preferredStyle: .Alert)
        
        subscribeAlert.addTextFieldWithConfigurationHandler { (txtOrgId) -> Void in
            txtOrgId.placeholder = "Member Id"
            
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
    
    @IBAction func rightMenu(sender: AnyObject) {
        delegate?.toggleRightPanel!()
    }
    
    @IBAction func segmentControl(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            self.tableView.hidden = false
//            self.btnAdd.setTitle("Add Member", forState: UIControlState.Normal)
            self.btnAdd.setImage(UIImage(named: "userAdd"), forState: UIControlState.Normal)
            self.tableView.reloadData()
        }
        else if segment.selectedSegmentIndex == 1 {
            self.tableView.hidden = false
//            self.btnAdd.setTitle("Add Team", forState: UIControlState.Normal)
            self.btnAdd.setImage(UIImage(named: "teamAdd"), forState: UIControlState.Normal)
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func addTeam(sender: AnyObject) {
        if segmentControl.selectedSegmentIndex == 0 {
            self.addMember()
        }
        else if segmentControl.selectedSegmentIndex == 1 {
            performSegueWithIdentifier("addTeamSeg", sender: self)
        }
    }

}
