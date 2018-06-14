//
//  CommonFunctions.swift
//  PostalOfficeSearch
//
//  Created by Hiren Samtani on 11/06/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showActivityIndicator(_ activityIndicator : UIActivityIndicatorView) {
        DispatchQueue.main.async{
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
        
        
    }
    
    func hideActivityIndicator(_ activityIndicator : UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    public func showInfo(withTitle: String = "Info", withMessage: String, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
                action?()
            }))
            self.present(ac, animated: true)
        }
    }
    
    
    func openWithSafari(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            showInfo(withTitle : "Error", withMessage: "Invalid link.")
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
}
