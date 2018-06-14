//
//  PostOffice.swift
//  PostalOfficeSearch
//
//  Created by Hiren Samtani on 10/06/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit
import CoreData



struct pOffice {
    let pincode : String
    let branchType : String
    let circle : String
    let country : String
    let deliveryStatus : String
    let description : String
    let district : String
    let division : String
    let name : String
    let region : String
    let state : String
    let taluk : String
    
    
    init(pincode : String,
         branchType : String,
         circle : String,
         country : String,
         deliveryStatus : String,
         description : String,
         district : String,
         division : String,
         name : String,
         region : String,
         state : String,
         taluk : String) {
        
        self.pincode = pincode
        self.branchType = branchType
        self.circle = circle
        self.country = country
        self.deliveryStatus = deliveryStatus
        self.description = description
        self.district = district
        self.division = division
        self.name = name
        self.region = region
        self.state = state
        self.taluk = taluk
    }
    
    init?(pincode : String,userInformation: [String:AnyObject])
    {
        
        self.pincode = pincode
        
        guard let branchType = userInformation["BranchType"] as? String else {
            return nil
        }
        self.branchType = branchType
        
        
        guard let circle = userInformation["Circle"] as? String else {
            return nil
        }
        self.circle = circle
        
        guard let country = userInformation["Country"] as? String else {
            return nil
        }
        self.country = country
        
        guard let deliveryStatus = userInformation["DeliveryStatus"] as? String else {
            return nil
        }
        self.deliveryStatus = deliveryStatus
        
        guard let description = userInformation["Description"] as? String else {
            return nil
        }
        self.description = description
        
        guard let district = userInformation["District"] as? String else {
            return nil
        }
        self.district = district
        
        guard let division = userInformation["Division"] as? String else {
            return nil
        }
        self.division = division
        
        guard let name = userInformation["Name"] as? String else {
            return nil
        }
        self.name = name
        
        guard let region = userInformation["Region"] as? String else {
            return nil
        }
        self.region = region
        
        guard let state = userInformation["State"] as? String else {
            return nil
        }
        self.state = state
        
        guard let taluk = userInformation["Taluk"] as? String else {
            return nil
        }
        self.taluk = taluk
        
    }
    
    init?(_ postOffice : PostOffice) {
        self.pincode = postOffice.pincode!
        self.branchType = postOffice.branchType!
        self.circle = postOffice.circle!
        self.country = postOffice.country!
        self.deliveryStatus = postOffice.deliveryStatus!
        self.description = postOffice.pDescription!
        self.district = postOffice.district!
        self.division = postOffice.division!
        self.name = postOffice.name!
        self.region = postOffice.region!
        self.state = postOffice.state!
        self.taluk = postOffice.taluk!
    }
    
    
}



extension PostOffice {
    convenience init(_ postOffice : pOffice,
                     _ context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.pincode = postOffice.pincode
        self.branchType = postOffice.branchType
        self.circle = postOffice.circle
        self.country = postOffice.country
        self.deliveryStatus = postOffice.deliveryStatus
        self.pDescription = postOffice.description
        self.district = postOffice.district
        self.division = postOffice.division
        self.name = postOffice.name
        self.region = postOffice.region
        self.state = postOffice.state
        self.taluk = postOffice.taluk
        
        
    }
    
    
}
