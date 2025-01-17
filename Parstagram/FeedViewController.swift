//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Chirag Kaudan on 10/1/20.
//  Copyright © 2020 fmoonlclassic. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    
    var posts = [PFObject]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

        // Do any additional setup after loading the view.

    }
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView?{
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return showsCommentBar
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           let query = PFQuery(className:"Posts")
           query.includeKeys(["author", "comments", "comments.author"])
           query.limit = 20
           
           query.findObjectsInBackground { (posts, error) in
               if posts != nil {
                   self.posts = posts!
                   self.tableView.reloadData()
               }
           }
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        
        return comments.count+2
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        if indexPath.row == 0 {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"PostCell") as! PostCell
        
       
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        //cell.photoView.af_setImage(withURL: url)
        cell.imageView?.af_setImage(withURL: url)
        return cell
        } else if indexPath.row <= comments.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            
            let comment = comments[indexPath.row - 1]
            cell.commentLabel.text = comment["text"] as? String
            
            let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            
            return cell
        }
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1 {
            showsCommentBar = true
            becomeFirstResponder()
            
            commentBar.inputTextView.becomeFirstResponder()
        }
        
   /*     comment["text"] = "This is a random comment"
        comment["post"] = post
        comment["author"] = PFUser.current()!
        
        post.add(comment, forKey: "comments")
        
        post.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")

            }
        } */
    }
    
    

    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var isFuncCalled = false
    @IBAction func onLogoutButton(_ sender: Any) {
        isFuncCalled = true
        if(isFuncCalled){
            print("Yes!")
        }
        
        PFUser.logOut()
        self.dismiss(animated: true, completion: nil)
        
        //let main = UIStoryboard(name: "Main", bundle: nil)
        //let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        
        //let delegate = UIApplication.shared.delegate as! AppDelegate
        
        //let presentedViewController = delegate.window?.rootViewController
        //let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        //let delegate = windowScene?.delegate as? SceneDelegate
        
        //windowScene.rootV
    }
    
}
