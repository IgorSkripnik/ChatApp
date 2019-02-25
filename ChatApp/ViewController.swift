//
//  ViewController.swift
//  ChatApp
//
//  Created by Igor Skripnik on 08.02.2019.
//  Copyright © 2019 garik. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref = DatabaseReference.init()
    
    var UserName:String?
    
    @IBOutlet weak var txtChatText: UITextField!
    
    @IBOutlet weak var laChatList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginAnony()
        
        //connection with Database of Firebase
        self.ref = Database.database().reference()
        
        laChatList.delegate = self
        laChatList.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfChatInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TVCChat = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TVCChat
        cell.setChat(chat: listOfChatInfo[indexPath.row])
        return cell
    }
    
    
    var listOfChatInfo = [Chat]()
    func loadChatRoom() {
        
        self.ref.child("chat").queryOrdered(byChild: "postDate").observe(.value, with:
            { (snapshot) in
                
                self.listOfChatInfo.removeAll()
                
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    
                    for snap in snapshot {
                        
                        if let postData = snap.value as? [String:AnyObject] {
                            
                            let userName = postData["name"] as? String
                            let text = postData["text"] as? String
                            
                            var postDate: CLong?
                            if let postDateIn = postData["postDate"] as? CLong {
                                postDate = postDateIn
                            }
                            
                            self.listOfChatInfo.append(Chat(userName: userName ?? "", text: text ?? "", datePost: "\(String(describing: postDate))"))
                        }
                    }
                    
                    self.laChatList.reloadData()
                    let indexPath = IndexPath(row: self.listOfChatInfo.count - 1, section: 0)
                    self.laChatList.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
        })
    }

    
    func loginAnony() {
        
        //user registration
        Auth.auth().signInAnonymously() {
            (user, error) in

            if let error = error {
                print("Cannnot login: \(error)")
            } else {
                print("User UID \(user?.user.uid ?? "")")
                self.loadChatRoom()
            }
        }
    }

    @IBAction func buSendToRoom(_ sender: Any) {
        
        //write data
        let dict = [    "text" : txtChatText.text as Any,
                        "name" : UserName!,
                    "postDate" : ServerValue.timestamp()] as [String : Any]
        
        //save data
        self.ref.child("chat").childByAutoId().setValue(dict)
        
    }
    

}

