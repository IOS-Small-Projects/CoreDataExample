//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Rohit on 14/09/16.
//  Copyright © 2016 Introp. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var userNam: UITextField!

    @IBOutlet var password: UITextField!
    
    @IBAction func loadBtnClicked(sender: AnyObject) {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        // filter on results
        request.predicate = NSPredicate(format: "username = %@", userNam.text!)
        
        var results:NSArray = []
        do{
             results = try context.executeFetchRequest(request)
        }
        catch{
            print("Error while reading data")
        }
        
        if results.count > 0 {
            print(results)
            
            let res = results[0] as! NSManagedObject
            
            userNam.text = res.valueForKey("username") as? String
            
            password.text = res.valueForKey("password") as? String
            
        }else{
            print("Error while reading data")
        }
        
        
    }
    
    @IBAction func saveBtnClicked(sender: AnyObject){
        
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        newUser.setValue(userNam.text, forKey: "username")
        newUser.setValue(password.text, forKey: "password")
        
        do{
            try context.save();
        }
        catch {
            print("Error while saving data")
        }
        
        print(newUser)
          userNam.text = ""
          password.text = ""
    }
}

