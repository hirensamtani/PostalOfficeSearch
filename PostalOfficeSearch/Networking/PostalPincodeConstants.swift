//
//  PostalPincodeConstants.swift
//  PostalOfficeSearch
//
//  Created by Hiren Samtani on 10/06/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import Foundation

extension PostalPincodeClient
{
    struct Constants
    {
        //MARK: URLS
        static let ApiScheme = "http"
        static let ApiHost = "postalpincode.in"
        static let ApiPath = "/api"
    }
    
    struct Methods
    {
        static let pincode = "/pincode/{PinCode}"
        static let postoffice = "/postoffice/{PostOffice}"
    }
    
    
    struct ParseResults
    {
        static let PostOffice = "PostOffice"
    }
    
    
}
