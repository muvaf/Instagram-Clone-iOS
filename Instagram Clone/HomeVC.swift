//
//  HomeVC.swift
//  Instagram Clone
//
//  Created by monus on 3/14/17.
//  Copyright © 2017 Muhammed Onus. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeVC: ViewController, UITableViewDataSource {

    @IBOutlet weak var postTableView: UITableView!
    var posts: [Post] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.dataSource = self
        // Do any additional setup after loading the view.
        refresh(nil)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        postTableView.insertSubview(refreshControl, at: 0)
    }
    @IBAction func logoutButtonClicked(_ sender: UIBarButtonItem) {
        PFUser.logOutInBackground { (error: Error?) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            self.show(loginVC, sender: nil)
        }
    }
    func refresh(_ refreshControl: UIRefreshControl?){
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (postsDict: [PFObject]?, error: Error?) in
            if let postsDict = postsDict {
                // do something with the data fetched
                self.posts = []
                for onePost in postsDict {
                    let post = Post(post: onePost)
                    self.posts.append(post)
                }
                self.postTableView.reloadData()
                if let refreshControl = refreshControl {
                    refreshControl.endRefreshing()
                }
            } else {
                // handle error
            }
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableCell
        
        cell.initWith(post: posts[ indexPath.row ])
        
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
