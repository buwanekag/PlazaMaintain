//
//  DetailViewController.swift
//  PlazaMaintain
//
//  Created by Buwaneka Galpoththawela on 11/5/15.
//  Copyright © 2015 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    var networkManager = NetworkManager.sharedInstance
    var dataManager = DataManager.sharedInstance
    var currentRepair: Tenants?
    
    var baseURLString = "boiling-ocean-2286.herokuapp.com"
    
    
    @IBOutlet var repairTitleLabel :UILabel!
    @IBOutlet var repairTitleTextField :UITextField!
    @IBOutlet var descriptionLabel :UILabel!
    @IBOutlet var descriprionTextField :UITextView!
  
    
    
    
    
    //MARK: - INTERACTIVITY METHOD
    
    
    @IBAction func submitButtonPressed(sender:UIButton) {
    sendRepairOrder(repairTitleTextField.text!, desc: descriprionTextField.text!)
        repairTitleTextField.text = ""
        descriprionTextField.text = ""
        
        }
    
    
    func currentRepairRequest() {
        
    }
    
    
    
    //MARK: - DATA METHOD
    
    func sendRepairOrder(title: String, desc: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "https://\(baseURLString)/api/repairs")
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        
        
        
        urlRequest.HTTPMethod = "POST"
        let token = "shophouse"
        
        urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let postString = "name=\(title)& repair_description=\(desc)"
        
        let postData = postString.dataUsingEncoding(NSUTF8StringEncoding)
        urlRequest.HTTPBody = postData
        
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) {
            data, response, error in 
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()){
                    let alert = UIAlertController (title: "Not Submited", message: "Your request was not sent", preferredStyle: .Alert)
                    
                    alert.addAction(UIAlertAction(title: "Resend", style: .Default, handler: nil ))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    print("error=\(error)")
                }
            
               return
           
            }else {
                dispatch_async(dispatch_get_main_queue()){
                    let alert = UIAlertController (title: "Submited", message: "Your request was sent", preferredStyle: .Alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil ))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }

            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
        }
        task.resume()
        
        
        
        
    }

    
    
    
    
    
    
    
    
    //MARK: - LIFE CYCLE METHOD

    override func viewDidLoad() {
        super.viewDidLoad()
   // imageView.image = UIImage(named: "Utility")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
}
