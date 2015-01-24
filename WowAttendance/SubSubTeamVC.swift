//
//  SubSubTeamVC.swift
//  WowAttendance
//
//  Created by Mohsin on 23/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class SubSubTeamVC: WowUIViewController, UITableViewDataSource, UITableViewDelegate  {
    
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
    var selectedTeamId = String()
    var selectedSubTeamId = String()
    var memberTypeWithOrg : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(selectedTeamId)
        
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
        
        
        println(selectedTeamId)
        
        if loginUser != nil {
            
            // if user's owner org clicked
            if self.memberTypeWithOrg == 0 {
                wowref.asynGetOrgById(self.selectedOrgId, callBack: { (orgList, observerHandle, orgRef) -> Void in
                    
                    if orgList != nil {
                        
                        let tempOrgs :  [String: [NSObject : AnyObject] ] = orgList!
                        let selectedOrg = tempOrgs[self.selectedOrgId]!
                        
                        
                        let tempTeamsList = (selectedOrg["teams"] as NSDictionary) as Dictionary
                        let tempSelectedTeam = (tempTeamsList[self.selectedTeamId] as NSDictionary) as Dictionary
                        
                        let tempSubTeamsList = (tempSelectedTeam["subteams"] as NSDictionary) as Dictionary
                        let tempSelectedSubTeam = (tempSubTeamsList[self.selectedSubTeamId] as NSDictionary) as Dictionary

                        // set the name, title and desc of selected org
                        let name = tempSelectedSubTeam["title"] as NSString
                        let desc = tempSelectedSubTeam["desc"] as NSString
                        self.setDesc("@\(self.selectedSubTeamId)", name: name, desc: desc)
                        
                        if tempSelectedSubTeam["subteams"] != nil {
                            self.teamList = (tempSelectedSubTeam["subteams"] as NSDictionary) as Dictionary
                        }
                        
                        if tempSelectedSubTeam["members"] != nil{
                            self.memberList = (tempSelectedSubTeam["members"] as NSDictionary) as Dictionary
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
                        
                        
                        let tempTeamsList = (selectedOrg["teams"] as NSDictionary) as Dictionary
                        let tempSelectedTeam = (tempTeamsList[self.selectedTeamId] as NSDictionary) as Dictionary
                        
                        let tempSubTeamsList = (tempSelectedTeam["subteams"] as NSDictionary) as Dictionary
                        let tempSelectedSubTeam = (tempSubTeamsList[self.selectedSubTeamId] as NSDictionary) as Dictionary
                        
                        // set the name, title and desc of selected org
                        let name = tempSelectedSubTeam["title"] as NSString
                        let desc = tempSelectedSubTeam["desc"] as NSString
                        self.setDesc("@\(self.selectedSubTeamId)", name: name, desc: desc)
                        
                        if tempSelectedSubTeam["subteams"] != nil {
                            self.teamList = (tempSelectedSubTeam["subteams"] as NSDictionary) as Dictionary
                        }
                        
                        if tempSelectedSubTeam["members"] != nil{
                            self.memberList = (tempSelectedSubTeam["members"] as NSDictionary) as Dictionary
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
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //select members segment
        if self.segmentControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = "@\(self.memberList.keys.array[indexPath.row] as NSString)"
            
            //            let firstName = self.memberList.values.array[indexPath.row]["firstName"] as NSString
            //            let lastName = self.memberList.values.array[indexPath.row]["lastName"] as NSString
            //            cell.detailTextLabel?.text = "\(firstName) \(lastName)"
            
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
        performSegueWithIdentifier("addTeamSeg", sender: self)
    }
    
    
}
