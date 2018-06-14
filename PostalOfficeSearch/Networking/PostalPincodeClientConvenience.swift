//
//  PostalPincodeClientConvenience.swift
//  PostalOfficeSearch
//
//  Created by Hiren Samtani on 10/06/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit


extension PostalPincodeClient {
    
    
    enum infoType{
        case pincode
        case branchName
        
    }
    
    private func subtituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
    
    //Get Postal Data
    func getPostalLocation(_ postalInfo: infoType, _ inpPostString: String ,completionHandlerForPostalLocation: @escaping (_ postalInfo: [[String:AnyObject]]? , _ postalInfoFound: Bool, _ error: NSError?) -> Void) -> Void
    {
        
        let method = postalInfo == .pincode ? subtituteKeyInMethod(method: Methods.pincode, key: "PinCode", value: inpPostString) : subtituteKeyInMethod(method: Methods.pincode, key: "PostOffice", value: inpPostString)
        
        let emptyParamDic = [String:AnyObject]()
        
        
        //        taskForGETMethod(parameters: parameters as [String : AnyObject], apiType : APIType.parse) { (result, error) in
        
        taskForGETMethod(method!, parameters: emptyParamDic) { (result, error) in
            
            
            guard (error == nil) else {
                completionHandlerForPostalLocation(nil, false, error)
                return
            }
            
            
            
            guard let resultPostOfficeInfo = result![ParseResults.PostOffice] as? [[String:AnyObject]] else {
                let userInfo = [NSLocalizedDescriptionKey : "Coulnd't find PostOffice key in '\(result!)"]
                completionHandlerForPostalLocation(nil, false, NSError(domain: "getStudentLocationFromParse", code: 1, userInfo: userInfo))
                return
            }
            guard resultPostOfficeInfo.count > 0 else {
                completionHandlerForPostalLocation(nil, false, nil)
                return
                
            }
            completionHandlerForPostalLocation(resultPostOfficeInfo, true, nil)
        }
        
        
    }
    
    
    
    
    
}
