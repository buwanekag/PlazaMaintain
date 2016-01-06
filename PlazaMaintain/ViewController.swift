//
//  ViewController.swift
//  PlazaMaintain
//
//  Created by Buwaneka Galpoththawela on 11/5/15.
//  Copyright © 2015 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate{
    
    var networkManager = NetworkManager.sharedInstance
    var dataManager = DataManager.sharedInstance
   
    @IBOutlet var repairList :UITableView!
    
   
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            let desController = segue.destinationViewController as! DetailViewController
            let touchPoint = sender!.convertPoint(CGPointZero, toView: repairList)
            let indexpath = repairList.indexPathForRowAtPoint(touchPoint)!
           // print("IP: \(indexpath.row)")
            let currentRepair = dataManager.tenantArray[indexpath.row]
            desController.currentRepair = currentRepair
            desController.popoverPresentationController?.delegate = self
        }
    }
       
    
    //MARK: - TABBLE VIEW METHOD
  
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.tenantArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TenantTableViewCell
       
        let displayUser = dataManager.tenantArray[indexPath.row]
             
        
        
        cell.repairDisplayLabel.text = displayUser.name
        cell.UtilityImage.image = UIImage(named: "Utility")
        
        print(displayUser)

        
        if  displayUser.completed! == true {
           // cell.statusLabel.hidden = false
            cell.detailsButton.hidden = false
            cell.statusImage.image  = UIImage(named: "Status")
            cell.statusImage.hidden = false
            
            
        }else{
           // cell.statusLabel.hidden = true
            cell.detailsButton.hidden = true
            cell.statusImage.image = UIImage(named: "Status")
            cell.statusImage.hidden = true
        }
        
        return cell
        
    }
    
    
    
 
    
    

    
    
    
    //MARK - INTERACTIVITY METHOD
    
    
    func newDataReceived() {
        print("new data")
        repairList.reloadData()
    }
    


    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil)
        
       dataManager.getDataFromServer()
        //repairList.reloadData()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

