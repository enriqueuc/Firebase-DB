//
//  ViewController.swift
//  Firebase DB
//
//  Created by Ing. Enrique Ugalde on 24/07/16.
//  Copyright © 2016 Ing. Enrique Ugalde. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        post()
    }
    
    func post(){
        
        let title = "Título"
        let message = "Message"
         
        //upload to DB
        
        let post : [String : AnyObject] = ["title" : title,
                                           "message" : message]
        //reference an specific db
        let databaseRef = FIRDatabase.database().reference()
        //access specific part of project
        databaseRef.child("Posts").childByAutoId().setValue(post)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

