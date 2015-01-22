//
//  TeamsVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class TeamsVC: WowUIViewController, UISplitViewControllerDelegate {

    
    var refTeam = ref.childByAppendingPath("teams/team5")
    
    var team : WowTeam! = nil{
        didSet{
            self.tableview.reloadData()
        }
    }
    
    var userInfo: String! = ""
    
    var adminsName : String! = ""
    
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var indLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var imgBackground: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Teams"        
        
        // enable the delegate,s functionality
        self.splitViewController?.delegate = self
        // hide the primary CV at startup
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryHidden
        
        // Assign the displayModeButtonItem to the vc navigation bar
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        self.navigationItem.leftItemsSupplementBackButton = true
        
        
        // load data from fire base
        self.team = WowTeam(ref: self.refTeam)
        
        self.tableview.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        self.tableview.separatorInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        
        self.btnAdd.layer.cornerRadius = 4.0

        
        
        if self.team.name == "" {
            self.team.ref.queryOrderedByKey().observeEventType(FEventType.Value, withBlock: { snapshot in
                
                if snapshot != NSNull() {
                    var admins = [String : Bool]()
                    var members = [String : Bool]()
                    var subTeams = [WowTeam]()
                    
                    
                    if let tempadmins = snapshot.value["admins"] as? [String : Bool] {
                        admins = tempadmins
                    }
                    if let tempmembers = snapshot.value["members"] as? [String : Bool] {
                        members = tempmembers
                    }
                    if let tempsubTeams = snapshot.value["subTeams"] as? [String : AnyObject] {
                        subTeams =  Model.mapToWowTeams(tempsubTeams, parent: self.refTeam)
                    }
                    
                    self.team = WowTeam(ref: self.refTeam, name: snapshot.key , admins: admins, members: members, SubTeams: subTeams)
                    
                    // when data load from server hidden the loading status from UI
                    self.lblLoading.hidden = true
                    self.indLoading.hidden = true
                    
                    self.adminsName = ""
                    
                    for x in self.team.admins.keys.array{
                        self.adminsName = self.adminsName + x + ", "
                    }
                }
                
            })
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.imgBackground.image = backgroundImage
    }
    
    // this func is hide the primary VC
    func targetDisplayModeForActionInSplitViewController(svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        return UISplitViewControllerDisplayMode.PrimaryOverlay
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.team.subTeams.count + self.team.members.count
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(self.team.name) - \(self.adminsName)"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row < self.team.subTeams.count {
//            let tempVC1 = self.storyboard?.instantiateViewControllerWithIdentifier("teamsID") as TeamsVC
//            //println(self.team.ref.childByAppendingPath("/subTeams/\(self.team.subTeams[indexPath.row].name)"))
//            tempVC1.refTeam = self.team.ref.childByAppendingPath("/subTeams/\(self.team.subTeams[indexPath.row].name)")
//            //tempVC1.team = self.team.subTeams[indexPath.row]
//            
//            presentViewController(tempVC1, animated: true, completion: nil)
            
            performSegueWithIdentifier("subTeamSeg", sender: indexPath)
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        if indexPath.row < self.team.subTeams.count{
            cell.textLabel?.text = self.team.subTeams[indexPath.row].name
            cell.textLabel?.textColor = UIColor.whiteColor()
            
            cell.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.2)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        else{
            cell.textLabel?.text = self.team.members.keys.array[indexPath.row - self.team.subTeams.count]
            cell.textLabel?.textColor = UIColor.whiteColor()
            
            cell.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
        }
        
        return cell
    }
    
    
    @IBAction func addTeam(sender: AnyObject) {
    performSegueWithIdentifier("addTeamSeg", sender: self)
    }
    
    @IBAction func logOut(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {
            self.performSegueWithIdentifier("logoutSeg", sender: nil)

        })
    }


    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "subTeamSeg"{
//            
//            let desVC = segue.destinationViewController as SubTeamsVC
//            
//            let indexPathForSelectedRow : NSIndexPath = sender as NSIndexPath
//            
//            desVC.refTeam = self.team.ref.childByAppendingPath("/subTeams/\(self.team.subTeams[indexPathForSelectedRow.row].name)")
//            
//        }
    }
    
    @IBAction func rightMenu(sender: AnyObject) {
        delegate?.toggleRightPanel!()
    }

}
