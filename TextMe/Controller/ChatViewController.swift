//
//  ChatViewController.swift
//  TextMe
//
//  Created by Michail Mishev on 6/12/17.
//  Copyright © 2017 Michail Mishev. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    var messageArray: [Message] = [Message]()
    

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var heightConstraints: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextField.delegate = self
        
        //monitoring for tab gestures:
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tabGesture)
        
        messageTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")    // nib == xib
        
        congigureTableViewHeight()
        
        retrieveMessages()
        
        messageTableView.separatorStyle = .none     ////removes line separators
 
    }
    
    
    
    
    
    //Requred TableView Methods:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomTableViewCell
        
//        let messageArray = ["FirstMessage", "SecondMessage SecondMessageSecondMessageSecondMessage SecondMessageSecondMessage SecondMessage SecondMessageSecondMessage", "ThirdMessage", "FourthMessage"]
//
//        cell.messageBody.text = messageArray[indexPath.row]

        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageVIew.image = UIImage(named: "girl-avatar-64x64")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String! {
            
            //messages we send:
            cell.avatarImageVIew.image = UIImage(named: "boy-avatar-64x64")
            cell.backgroundMessage.backgroundColor = UIColor(red: 255.0/255.0, green: 126.0/255.0, blue: 121.0/255.0, alpha: 1.0)
            cell.senderUsername.textColor = UIColor(red: 255.0/255.0, green: 212.0/255.0, blue: 121.0/255.0, alpha: 1.0)

        } else {
            //messages from others:
        }
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return 4
        return messageArray.count
        
    }
    
    // ---------------------------------------
    
    
    
    
    
    @objc func tableViewTapped() {
        
        messageTextField.endEditing(true)
        
    }
    
    
    
    
    func congigureTableViewHeight() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBAction func logoutPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            navigationController?.popViewController(animated: true)
        }
        catch {
            print("Error: There was a problem signing out.")
        }
        
        
    }
    
    
    
    //message sender box pops-up with animation for the keyboard:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.6, animations: {
            self.heightConstraints.constant = 258 + 50       // 258 = keyboard height
            self.view.layoutIfNeeded()
        })
        
    }
    
    
    
    //message sender box return when no keyboard:
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.6, animations: {
            self.heightConstraints.constant = 50     // 50 = send message box height
            self.view.layoutIfNeeded()
        })
        
    }
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        //
        messageTextField.endEditing(true)
        
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextField.text!]
        
        messageDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("Message saved successfully!")
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
            
        }
        
    }
    
    
    
    
    func retrieveMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
//            print(text, sender)
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            self.congigureTableViewHeight()
            self.messageTableView.reloadData()
            
        }
        
    }
    
    
  

}
