
//
//  DataManager.swift
//  PlazaMaintain
//
//  Created by Buwaneka Galpoththawela on 11/5/15.
//  Copyright © 2015 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    var baseURLString = "boiling-ocean-2286.herokuapp.com"
    var tenantArray = [Tenants]()
    
    
    
    
    
    
    //MARK: - DATA METHOD
    
    
    func parseTuneData(data:NSData){
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            
            let tempDictArray = jsonResult.objectForKey("repairs") as! [NSDictionary]
            
            
            for ticketDict in tempDictArray {
                let newTicket = Tenants()
                
                
                
               newTicket.name = ticketDict.objectForKey("name") as! String
               newTicket.completed = ticketDict.objectForKey("completed") as! Bool
               newTicket.repair_description = ticketDict.objectForKey("repair_description") as! String
                
                self.tenantArray.append(newTicket)
                print("TicketName:\(newTicket.name)")
            }
            dispatch_async(dispatch_get_main_queue()){
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedDataFromServer", object: nil))
            }
        } catch {
            print("JSON Parsing Error")
        }
        
    }

    
    func getDataFromServer() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
      
        
        let url = NSURL(string: "https://\(baseURLString)/api/repairs")
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
     
        
        
        urlRequest.HTTPMethod = "GET"
        let token = "shophouse"
        urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if data != nil {
                print("Got Data")
                self.parseTuneData(data!)
            } else {
                print("No Data")
            }
        }
        task.resume()
    }
    
    
    
    
    
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
                
                
                
                print("error=\(error)")
                return
            }
            
            //print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
           // print("responseString = \(responseString)")
        }
        task.resume()
        
        
        
        
    }


    
    func deleteRepairOrder(title: String, desc: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "https://\(baseURLString)/api/repairs")
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        
        urlRequest.HTTPMethod = "DELETE"
        let token = "shophouse"
        
        urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let postString = "name=\(title)& repair_description=\(desc)"
        
        let postData = postString.dataUsingEncoding(NSUTF8StringEncoding)
        urlRequest.HTTPBody = postData
        
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) {
            data, response, error in
            
            if error != nil {
                
                
                
                print("error=\(error)")
                return
            }
            
            //print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            // print("responseString = \(responseString)")
        }
        task.resume()
        
        
        
        
    }

    
    

}
