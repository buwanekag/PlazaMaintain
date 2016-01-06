//
//  TenantDetailViewController.swift
//  PlazaMaintain
//
//  Created by Buwaneka Galpoththawela on 11/8/15.
//  Copyright © 2015 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class TenantDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    

    let messageComposer = MessageComposer()
    var dataManager = DataManager.sharedInstance
    
    var currentRepair: Tenants?

    
    @IBOutlet var descriptionDisplayTabel: UITableView!
    

    
    
    //MARK: INTERACTIVE METHOD 
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("viewCell", forIndexPath: indexPath) as! DescViewTableViewCell
        
        cell.descriptionTextField.text = currentRepair!.repair_description
        

   
         return cell
    }
    
    
    //MARK: - MESSAGE METHOD
    
    @IBAction func sendTextMessageButtonTapped(sender: UIButton) {
        if (messageComposer.canSendText()) {
        let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            
                        presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }

    
    
    
    
    //MARK: LIFE CYCLE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
}
