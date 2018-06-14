//
//  SearchDetailsViewController.swift
//  PostalOfficeSearch
//
//  Created by Hiren Samtani on 11/06/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit
import CoreData

class SearchDetailsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var infoText: UILabel!
    
    var pOfficeData : [pOffice]?
    
    var stack: DataController!
    
    var defaults = UserDefaults.standard
    
    var loadNew : Bool = false
    
    var postOffice : [PostOffice] = [PostOffice]()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        print("pOfficeData cnt", postOffice.count)
        
        onLoadNew(loadNew)
        tableView.reloadData()
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator(activityIndicator)
        
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        stack = delegate.stack
        
        //        postOffice = fetchPostOffice();
        
        onLoadNew(loadNew)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        hideActivityIndicator(activityIndicator)
        
        
        
    }
    
    
    
    
    
    
    
    func onLoadNew (_ loadNew : Bool) {
        postOffice = fetchPostOffice();
        if(!loadNew) {
            navigationBar.isHidden = true
            infoText.text = "Swipe To Delete"
            
            
            pOfficeData = []
            for pStub in postOffice {
                
                let ptemp = pOffice(pStub)
                
                pOfficeData?.append(ptemp!)
                
            }
        }
        else {
            infoText.text = "Swipe To Save"
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pOfficeData != nil {
            return pOfficeData!.count
        }
        else {
            return 0
        }
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "postofficeCell", for: indexPath)
        //        let udacityUser = UdacityUsersModel.sharedInstance.getUserForIndex(index: indexPath.row)
        cell.textLabel?.text = "\(pOfficeData![indexPath.row].name) - \(pOfficeData![indexPath.row].branchType)"
        cell.detailTextLabel?.text = "\(pOfficeData![indexPath.row].taluk) - \(pOfficeData![indexPath.row].division)"
        
        
        return cell
    }
    
    
    
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        return setSwipeActionConfig(!loadNew,indexPath,action: print("left swipe"),tableView)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        return setSwipeActionConfig(!loadNew,indexPath,action: print("right swipe"),tableView)
    }
    
    func setSwipeActionConfig(_ destructive : Bool, _ indexPath: IndexPath,action: (), _ tableView: UITableView) -> UISwipeActionsConfiguration {
        let swipeActions : UISwipeActionsConfiguration
        
        if(destructive) {
            let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
                action
                self.removePostOffice(indexPath.row)
                print("Trailing Action style .destructive")
            }
            
            swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            swipeActions.performsFirstActionWithFullSwipe = true
            
        }
        else {
            let contextItem = UIContextualAction(style: .normal, title: "Save") { (contextualAction, view, boolValue) in
                action
                self.addPostOffice(indexPath.row)
                print("Leading Action style .normal")
            }
            
//            swipeActions.performsFirstActionWithFullSwipe = true
            
            swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            swipeActions.performsFirstActionWithFullSwipe = true
            
        }
        
        
        return swipeActions
    }
    
    
    
    func fetchPostOffice() -> [PostOffice] {
        var postOffice = [PostOffice]()
        let fr: NSFetchRequest<NSFetchRequestResult> = PostOffice.fetchRequest()
        //        print("in fetch results")
        do {
            
            let results = try stack.viewContext.fetch(fr) as! [PostOffice]
            
            postOffice = results
        } catch let e as NSError {
            print("Error while trying to perform a search: \n\(e)")
        }
        
        return postOffice
    }
    
    
    func addPostOffice(_ ind : Int) {
        
        let postOfficeArrStub = pOfficeData![ind]
        //        print("add called")
        
        
        
        if !postOfficeExists(pincode: postOfficeArrStub.pincode,name: postOfficeArrStub.name){
            
            
            let pOffice: PostOffice = PostOffice(postOfficeArrStub,stack.viewContext)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.saveViewContext()
            print("stack saved", postOffice.count)
            showInfo(withTitle: "", withMessage: "Post Office Saved To Favourites", action: tableView.reloadData)
        }
        else {
            showInfo(withTitle: "", withMessage: "Post Office Already Saved To Favourites", action: tableView.reloadData)
        }
        
        
        
    }
    
    func removePostOffice(_ ind : Int) {
        
        let postOfficeObjStub = postOffice[ind]
        
        do{
            //            print(postOfficeObjStub.name)
            stack.viewContext.delete(postOfficeObjStub)
            //            print("Delete called")
            try stack.viewContext.save()
            pOfficeData?.remove(at: ind)
            tableView.reloadData()
            showInfo(withTitle: "", withMessage: "Post Office Removed From Favourites", action: nil)
        } catch {
            let nserror = error as NSError
            assertionFailure()
            showInfo(withTitle: "Error", withMessage: "Unable to delete post office", action: nil)
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        
    }
    
    func postOfficeExists(pincode : String, name : String) -> Bool{
        postOffice = fetchPostOffice()
        
        for stub in postOffice {
            print(stub.name)
            if stub.pincode == pincode && stub.name == name {
                return true
            }
        }
        
        return false
    }
    
    
}
