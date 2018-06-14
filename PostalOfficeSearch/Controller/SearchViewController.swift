//
//  SearchViewController.swift
//  PostalOfficeSearch
//
//  Created by Hiren Samtani on 10/06/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    
    @IBOutlet weak var pincode: UITextField!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    var pOfficeData : [pOffice] = [pOffice] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideActivityIndicator(activityIndicator)
    }
    
    
    @IBAction func Search(_ sender: Any) {
        showActivityIndicator(activityIndicator)
        
        PostalPincodeClient.sharedInstance.getPostalLocation(PostalPincodeClient.infoType.pincode, pincode.text!, completionHandlerForPostalLocation:{ (postOfficeInfo, infofound ,error) in
            
            
            DispatchQueue.main.sync {
                
                guard (error == nil) else {
                    self.showInfo(withTitle: "Error", withMessage: (error?.description)!, action: nil)
                    self.hideActivityIndicator(self.activityIndicator)
                    return
                }
                
                guard (postOfficeInfo != nil) else {
                    self.showInfo(withTitle: "Error", withMessage: "Error getting post office info", action: nil)
                    self.hideActivityIndicator(self.activityIndicator)
                    return
                }
                
                self.pOfficeData.removeAll()
                
                for postOffice in postOfficeInfo! {
                    guard let pOfficeStub = pOffice(pincode: self.pincode.text!,userInformation: postOffice) else {
                        continue
                    }
                    
                   
                    self.pOfficeData.append(pOfficeStub)
                }
                
                self.hideActivityIndicator(self.activityIndicator)
                self.performSegue(withIdentifier: "showdetails", sender: self)
                
            }
            
        })
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdetails" {
            if let searchDetailsController = segue.destination as? SearchDetailsViewController {
                
                searchDetailsController.pOfficeData = pOfficeData
                searchDetailsController.loadNew = true
            }
        }
    }
    
    
}

