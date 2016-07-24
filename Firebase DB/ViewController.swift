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

//define struct of post
struct postStructure {
    let title : String!
    let message : String!
}

class ViewController: UITableViewController {
    
    //to work with the post
    var posts = [postStructure]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //load data from DB
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("Posts").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            let title = snapshot.value!["title"] as! String
            let message = snapshot.value!["message"] as! String
            
            self.posts.insert(postStructure(title: title, message: message), atIndex: 0)
            
            self.tableView.reloadData()
                })
        
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = posts[indexPath.row].title
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = posts[indexPath.row].message
        
        return cell!
    }
}

