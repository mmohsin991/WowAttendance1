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
    
    
    var ownersList : [String: [String: String]]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //segmrnted control default selection
        self.segmentControl.setEnabled(true, forSegmentAtIndex: 0)

        
        // table view configurations
        self.tableView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.greenColor()
        self.navigationItem.titleView = imgBarLogo
        
        println("HomeVCload")
        
        if loginUser != nil{
            lblName.text = "\(loginUser!.firstName) \(loginUser!.lastName)"
            lblEmail.text = loginUser?.email
            
        }
        
      //  delegate?.collapseSidePanels!()
        
        
        wowref.asyncGetUsesOwnerOrgsList("mmohsin", callBack: { (ownersList) -> Void in
            if ownersList != nil {
                self.ownersList = ownersList
                println(self.ownersList)
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
     //   self.imgBackground.image = backgroundImage
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logoutSeg"{
            
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "place holder"
        cell.textLabel?.textColor = colorLBlue
        
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        cell.separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    

    @IBAction func rightMenu(sender: AnyObject) {
        delegate?.toggleRightPanel!()
    }
    
    @IBAction func segmentControl(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            self.tableView.hidden = false
            self.btnAdd.hidden = false
        }
        else if segment.selectedSegmentIndex == 1 {
            self.tableView.hidden = false
            self.btnAdd.hidden = true
        }
        
    }
    
    @IBAction func addTeam(sender: AnyObject) {
        performSegueWithIdentifier("addTeamSeg", sender: self)
    }
    

}
